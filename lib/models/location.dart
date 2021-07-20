class Location {
  int id;
  String location;

  Location({
    this.id,
    this.location,
  });

  factory Location.fromJson(Map<String, dynamic> currency) {
    return Location(
      id: currency['id'],
      location: currency['currency'],
    );
  }

  @override
  String toString() {
    return 'id: ${id}, UserId: ${location}';
  }
}
