class Currency {
  int id;
  String currency;

  Currency({
    this.id,
    this.currency,
  });

  factory Currency.fromJson(Map<String, dynamic> currency) {
    return Currency(
      id: currency['id'],
      currency: currency['currency'],
    );
  }

  @override
  String toString() {
    return 'id: ${id}, currency: ${currency}';
  }
}
