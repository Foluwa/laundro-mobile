class Flutterwave {
  int id;
  String encryptionKey;
  String publicKey;

  Flutterwave({
    required this.id,
    required this.encryptionKey,
    required this.publicKey,
  });

  factory Flutterwave.fromJson(flutterwave) {
    return Flutterwave(
      id: flutterwave['id'] ?? '',
      encryptionKey: flutterwave['encryptionKey'] ?? '',
      publicKey: flutterwave['publicKey'] ?? '',
    );
  }
}
