enum QrType { text, url, wifi, contact, email, sms }

class QrCodeItem {
  final String id;
  final String title;
  final String content;
  final QrType type;
  final DateTime createdAt;
  final bool isGenerated; // true if created by user, false if scanned
  final bool isFavorite;
  final String? foregroundColorHex;
  final String? backgroundColorHex;

  QrCodeItem({
    required this.id,
    required this.title,
    required this.content,
    required this.type,
    required this.createdAt,
    this.isGenerated = true,
    this.isFavorite = false,
    this.foregroundColorHex,
    this.backgroundColorHex,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'content': content,
        'type': type.name,
        'createdAt': createdAt.toIso8601String(),
        'isGenerated': isGenerated,
        'isFavorite': isFavorite,
        'foregroundColorHex': foregroundColorHex,
        'backgroundColorHex': backgroundColorHex,
      };

  factory QrCodeItem.fromJson(Map<String, dynamic> json) => QrCodeItem(
        id: json['id'] ?? '',
        title: json['title'] ?? 'QR Code',
        content: json['content'] ?? '',
        type: QrType.values.firstWhere(
          (e) => e.name == json['type'],
          orElse: () => QrType.text,
        ),
        createdAt: DateTime.parse(json['createdAt']),
        isGenerated: json['isGenerated'] ?? true,
        isFavorite: json['isFavorite'] ?? false,
        foregroundColorHex: json['foregroundColorHex'],
        backgroundColorHex: json['backgroundColorHex'],
      );
}
