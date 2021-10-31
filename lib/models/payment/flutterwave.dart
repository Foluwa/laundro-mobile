class FlutterwaveModel {
  int id;
  String encryptionKey;
  String publicKey;

  FlutterwaveModel({
    required this.id,
    required this.encryptionKey,
    required this.publicKey,
  });

  factory FlutterwaveModel.fromJson(flutterwave) {
    return FlutterwaveModel(
      id: flutterwave['id'] ?? '',
      encryptionKey: flutterwave['encryptionKey'] ?? '',
      publicKey: flutterwave['publicKey'] ?? '',
    );
  }
}
