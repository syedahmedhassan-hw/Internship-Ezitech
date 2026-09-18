import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/qr_code_item.dart';

class QrProvider extends ChangeNotifier {
  List<QrCodeItem> _qrHistory = [];
  String _searchQuery = '';
  QrType? _filterType;
  bool _showOnlyFavorites = false;

  List<QrCodeItem> get qrHistory {
    return _qrHistory.where((item) {
      final matchesSearch = item.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          item.content.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesType = _filterType == null || item.type == _filterType;
      final matchesFav = !_showOnlyFavorites || item.isFavorite;
      return matchesSearch && matchesType && matchesFav;
    }).toList();
  }

  String get searchQuery => _searchQuery;
  QrType? get filterType => _filterType;
  bool get showOnlyFavorites => _showOnlyFavorites;

  QrProvider() {
    _loadQrHistory();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setFilterType(QrType? type) {
    _filterType = type;
    notifyListeners();
  }

  void toggleFavoriteFilter() {
    _showOnlyFavorites = !_showOnlyFavorites;
    notifyListeners();
  }

  Future<QrCodeItem> createQrCode({
    required String title,
    required String content,
    required QrType type,
    String? fgColor,
    String? bgColor,
  }) async {
    final newItem = QrCodeItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title.isEmpty ? _inferTitle(content, type) : title,
      content: content,
      type: type,
      createdAt: DateTime.now(),
      isGenerated: true,
      foregroundColorHex: fgColor,
      backgroundColorHex: bgColor,
    );

    _qrHistory.insert(0, newItem);
    notifyListeners();
    await _saveQrHistory();
    return newItem;
  }

  Future<QrCodeItem> addScannedResult(String rawData) async {
    final type = _inferTypeFromContent(rawData);
    final newItem = QrCodeItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: _inferTitle(rawData, type),
      content: rawData,
      type: type,
      createdAt: DateTime.now(),
      isGenerated: false,
    );

    _qrHistory.insert(0, newItem);
    notifyListeners();
    await _saveQrHistory();
    return newItem;
  }

  Future<QrCodeItem?> scanImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;

    final MobileScannerController controller = MobileScannerController();
    try {
      final BarcodeCapture? capture = await controller.analyzeImage(image.path);
      if (capture != null && capture.barcodes.isNotEmpty) {
        final String? rawValue = capture.barcodes.first.rawValue;
        if (rawValue != null && rawValue.isNotEmpty) {
          return await addScannedResult(rawValue);
        }
      }
    } catch (e) {
      debugPrint("Error scanning image: $e");
    } finally {
      controller.dispose();
    }
    return null;
  }

  void toggleFavorite(String id) async {
    final idx = _qrHistory.indexWhere((item) => item.id == id);
    if (idx != -1) {
      final old = _qrHistory[idx];
      _qrHistory[idx] = QrCodeItem(
        id: old.id,
        title: old.title,
        content: old.content,
        type: old.type,
        createdAt: old.createdAt,
        isGenerated: old.isGenerated,
        isFavorite: !old.isFavorite,
        foregroundColorHex: old.foregroundColorHex,
        backgroundColorHex: old.backgroundColorHex,
      );
      notifyListeners();
      await _saveQrHistory();
    }
  }

  void deleteQrCode(String id) async {
    _qrHistory.removeWhere((item) => item.id == id);
    notifyListeners();
    await _saveQrHistory();
  }

  void clearHistory() async {
    _qrHistory.clear();
    notifyListeners();
    await _saveQrHistory();
  }

  QrType _inferTypeFromContent(String content) {
    final lower = content.trim().toLowerCase();
    if (lower.startsWith('http://') || lower.startsWith('https://') || lower.startsWith('www.')) {
      return QrType.url;
    } else if (lower.startsWith('wifi:') || lower.startsWith('wpa:')) {
      return QrType.wifi;
    } else if (lower.startsWith('mailto:')) {
      return QrType.email;
    } else if (lower.startsWith('smsto:') || lower.startsWith('sms:')) {
      return QrType.sms;
    } else if (lower.startsWith('begin:vcard')) {
      return QrType.contact;
    }
    return QrType.text;
  }

  String _inferTitle(String content, QrType type) {
    switch (type) {
      case QrType.url:
        return "Web Link";
      case QrType.wifi:
        return "Wi-Fi Access Point";
      case QrType.contact:
        return "Contact Card";
      case QrType.email:
        return "Email Address";
      case QrType.sms:
        return "SMS Message";
      case QrType.text:
        return content.length > 25 ? "${content.substring(0, 25)}..." : content;
    }
  }

  Future<void> _saveQrHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = _qrHistory.map((item) => item.toJson()).toList();
    await prefs.setString('qr_history', jsonEncode(jsonList));
  }

  Future<void> _loadQrHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString('qr_history');
    if (jsonStr != null) {
      try {
        final List<dynamic> list = jsonDecode(jsonStr);
        _qrHistory = list.map((item) => QrCodeItem.fromJson(item)).toList();
        notifyListeners();
      } catch (_) {}
    }
  }
}
