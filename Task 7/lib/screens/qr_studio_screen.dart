import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import '../models/qr_code_item.dart';
import '../providers/qr_provider.dart';
import '../widgets/glass_card.dart';

class QrStudioScreen extends StatefulWidget {
  const QrStudioScreen({super.key});

  @override
  State<QrStudioScreen> createState() => _QrStudioScreenState();
}

class _QrStudioScreenState extends State<QrStudioScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _contentCtrl = TextEditingController(text: "https://github.com");
  final TextEditingController _titleCtrl = TextEditingController(text: "My Project");

  QrType _selectedType = QrType.url;
  Color _fgColor = Colors.white;
  Color _bgColor = Colors.black;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _contentCtrl.dispose();
    _titleCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final qrProv = Provider.of<QrProvider>(context);
    final primary = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: const Text("QR Studio"),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: primary,
          labelColor: primary,
          unselectedLabelColor: Colors.grey,
          tabs: const [
            Tab(icon: Icon(Icons.qr_code, size: 20), text: "Generator"),
            Tab(icon: Icon(Icons.qr_code_scanner, size: 20), text: "Scanner"),
            Tab(icon: Icon(Icons.history, size: 20), text: "History"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildGeneratorTab(qrProv, primary),
          _buildScannerTab(qrProv, primary),
          _buildHistoryTab(qrProv, primary),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // TAB 1: QR CODE GENERATOR
  // ---------------------------------------------------------------------------
  Widget _buildGeneratorTab(QrProvider qrProv, Color primary) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 110),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // QR Type Selector Chips
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: QrType.values.map((type) {
                final isSelected = _selectedType == type;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(type.name.toUpperCase()),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedType = type;
                      });
                    },
                    selectedColor: primary.withValues(alpha: 0.2),
                    checkmarkColor: primary,
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 16),

          // Inputs
          GlassCard(
            child: Column(
              children: [
                TextField(
                  controller: _titleCtrl,
                  decoration: const InputDecoration(
                    labelText: "QR Code Label",
                    hintText: "e.g. Website, Wi-Fi, Contact",
                    prefixIcon: Icon(Icons.label_outline),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (_) => setState(() {}),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _contentCtrl,
                  maxLines: _selectedType == QrType.text ? 3 : 1,
                  decoration: InputDecoration(
                    labelText: _getLabelForType(_selectedType),
                    hintText: _getHintForType(_selectedType),
                    prefixIcon: const Icon(Icons.link),
                    border: const OutlineInputBorder(),
                  ),
                  onChanged: (_) => setState(() {}),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Live QR Preview Card
          GlassCard(
            child: Column(
              children: [
                const Text("LIVE QR PREVIEW", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey)),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _bgColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                  ),
                  child: QrImageView(
                    data: _contentCtrl.text.isEmpty ? "https://github.com" : _contentCtrl.text,
                    version: QrVersions.auto,
                    size: 200.0,
                    eyeStyle: QrEyeStyle(
                      eyeShape: QrEyeShape.square,
                      color: _fgColor,
                    ),
                    dataModuleStyle: QrDataModuleStyle(
                      dataModuleShape: QrDataModuleShape.circle,
                      color: _fgColor,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Color Presets
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildColorDot("Default White", Colors.white, Colors.black),
                    const SizedBox(width: 12),
                    _buildColorDot("Cyber Cyan", const Color(0xFF00E5FF), const Color(0xFF05131A)),
                    const SizedBox(width: 12),
                    _buildColorDot("Emerald", const Color(0xFF00E676), const Color(0xFF071F14)),
                    const SizedBox(width: 12),
                    _buildColorDot("Violet", const Color(0xFFD500F9), const Color(0xFF1B0726)),
                  ],
                ),
                const SizedBox(height: 20),

                // Save & Share Buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          if (_contentCtrl.text.trim().isEmpty) return;
                          await qrProv.createQrCode(
                            title: _titleCtrl.text.trim(),
                            content: _contentCtrl.text.trim(),
                            type: _selectedType,
                          );
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("QR Code saved to History!")),
                            );
                            _tabController.animateTo(2); // Switch to History tab
                          }
                        },
                        icon: const Icon(Icons.save_alt),
                        label: const Text("Save to History"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primary,
                          foregroundColor: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton.outlined(
                      onPressed: () {
                        Share.share("QR Code Content:\n${_contentCtrl.text}");
                      },
                      icon: const Icon(Icons.share),
                      tooltip: "Share Content",
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildColorDot(String name, Color fg, Color bg) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _fgColor = fg;
          _bgColor = bg;
        });
      },
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: bg,
          shape: BoxShape.circle,
          border: Border.all(color: fg, width: 3),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // TAB 2: QR & BARCODE CAMERA SCANNER
  // ---------------------------------------------------------------------------
  Widget _buildScannerTab(QrProvider qrProv, Color primary) {
    return Column(
      children: [
        // Camera View Container
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: primary.withValues(alpha: 0.5), width: 2),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  MobileScanner(
                    onDetect: (BarcodeCapture capture) async {
                      final List<Barcode> barcodes = capture.barcodes;
                      if (barcodes.isNotEmpty && barcodes.first.rawValue != null) {
                        final val = barcodes.first.rawValue!;
                        final item = await qrProv.addScannedResult(val);
                        if (mounted) {
                          _showScanResultModal(context, item);
                        }
                      }
                    },
                  ),

                  // Overlay Scanner Frame Target
                  Container(
                    width: 220,
                    height: 220,
                    decoration: BoxDecoration(
                      border: Border.all(color: primary, width: 3),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),

                  // Bottom Action Bar inside Scanner
                  Positioned(
                    bottom: 20,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.center_focus_weak, color: Colors.white, size: 20),
                          SizedBox(width: 8),
                          Text(
                            "Align QR Code within Frame",
                            style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // Gallery File Picker Fallback Scanner Button
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: GlassCard(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Scan from Saved Image", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("Pick a QR image file from your gallery", style: TextStyle(fontSize: 11, color: Colors.grey)),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    final result = await qrProv.scanImageFromGallery();
                    if (result != null && mounted) {
                      _showScanResultModal(context, result);
                    } else if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("No valid QR code found in selected image.")),
                      );
                    }
                  },
                  icon: const Icon(Icons.image, size: 18),
                  label: const Text("Pick Image"),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // TAB 3: SCAN & GENERATOR HISTORY
  // ---------------------------------------------------------------------------
  Widget _buildHistoryTab(QrProvider qrProv, Color primary) {
    final history = qrProv.qrHistory;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Search & Filter Bar
          TextField(
            decoration: InputDecoration(
              hintText: "Search saved QR history...",
              prefixIcon: const Icon(Icons.search),
              suffixIcon: qrProv.searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () => qrProv.setSearchQuery(""),
                    )
                  : null,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
            ),
            onChanged: (val) => qrProv.setSearchQuery(val),
          ),
          const SizedBox(height: 12),

          if (history.isEmpty)
            const Expanded(
              child: Center(
                child: Text("No matching QR history items found.", style: TextStyle(color: Colors.grey)),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: history.length,
                itemBuilder: (context, index) {
                  final item = history[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.04),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
                    ),
                    child: ListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: item.isGenerated
                              ? primary.withValues(alpha: 0.15)
                              : const Color(0xFF7C4DFF).withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          item.isGenerated ? Icons.qr_code : Icons.qr_code_scanner,
                          color: item.isGenerated ? primary : const Color(0xFF7C4DFF),
                          size: 20,
                        ),
                      ),
                      title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(
                        item.content,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              item.isFavorite ? Icons.star : Icons.star_border,
                              color: item.isFavorite ? const Color(0xFFFFAB00) : Colors.grey,
                              size: 20,
                            ),
                            onPressed: () => qrProv.toggleFavorite(item.id),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete_outline, color: Colors.grey, size: 20),
                            onPressed: () => qrProv.deleteQrCode(item.id),
                          ),
                        ],
                      ),
                      onTap: () => _showScanResultModal(context, item),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  void _showScanResultModal(BuildContext context, QrCodeItem item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(item.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Chip(label: Text(item.type.name.toUpperCase())),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12),
              ),
              child: SelectableText(
                item.content,
                style: const TextStyle(fontSize: 14, fontFamily: 'monospace'),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: item.content));
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Content copied to clipboard!")),
                      );
                    },
                    icon: const Icon(Icons.copy),
                    label: const Text("Copy"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Share.share(item.content);
                      Navigator.pop(ctx);
                    },
                    icon: const Icon(Icons.share),
                    label: const Text("Share"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getLabelForType(QrType type) {
    switch (type) {
      case QrType.url:
        return "Web URL Address";
      case QrType.wifi:
        return "Wi-Fi Configuration String (WPA/WEP)";
      case QrType.contact:
        return "vCard Contact Details";
      case QrType.email:
        return "Target Email Address";
      case QrType.sms:
        return "Phone Number / Message";
      case QrType.text:
        return "Plain Text Content";
    }
  }

  String _getHintForType(QrType type) {
    switch (type) {
      case QrType.url:
        return "https://example.com";
      case QrType.wifi:
        return "WIFI:S:MyNetwork;P:MyPassword;;";
      case QrType.contact:
        return "BEGIN:VCARD\nFN:John Doe\nTEL:+1234567890\nEND:VCARD";
      case QrType.email:
        return "mailto:contact@domain.com";
      case QrType.sms:
        return "smsto:+1234567890:Hello World";
      case QrType.text:
        return "Enter any custom text content...";
    }
  }
}
