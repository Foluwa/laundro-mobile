class LocationList {
  List<Location> location;
  LocationList({required this.location});

  factory LocationList.fromJson(location) {
    print('INSIDE LocationList $location');
    final operations = location as List;
    final data = operations.map((f) => Location.fromJson(f)).toList();
    return LocationList(location: data);
  }
}

class Location {
  int id;
  String location;
  double price;

  Location({
    required this.id,
    required this.location,
    required this.price,
  });

  factory Location.fromJson(Map<String, dynamic> location) {
    return Location(
      id: location['id'],
      location: location['Place'],
      price: location['Price'],
    );
  }

  @override
  String toString() {
    return 'id: ${id}, location: ${location}, price: ${price}';
  }
}
