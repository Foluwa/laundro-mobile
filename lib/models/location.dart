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

  Location({
    required this.id,
    required this.location,
  });

  factory Location.fromJson(Map<String, dynamic> location) {
    return Location(
      id: location['id'],
      location: location['Place'],
    );
  }

  @override
  String toString() {
    return 'id: ${id}, location: ${location}';
  }
}
