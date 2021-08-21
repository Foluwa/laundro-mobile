class User {
  int id;
  String username;
  String first_name;
  String last_name;
  String phone_number;
  String email;
  String provider;
  bool confirmed;
  var blocked = false;
  int role_id;
  String role_name;
  String role_type;
  String created_at;
  String updated_at;
  String home_address;

  User(
      {required this.id,
      required this.username,
      required this.first_name,
      required this.last_name,
      required this.phone_number,
      required this.email,
      required this.provider,
      required this.confirmed,
      required this.blocked,
      required this.role_id,
      required this.role_name,
      required this.role_type,
      required this.created_at,
      required this.updated_at,
      required this.home_address});

  factory User.fromJson(Map<String, dynamic> user) {
    return User(
      id: user['id'],
      username: user['username'],
      first_name: user['firstName'],
      last_name: user['lastName'],
      phone_number: user['phoneNumber'],
      home_address: user['homeAddress'],
      email: user['email'],
      provider: user['provider'],
      confirmed: user['confirmed'] ?? false,
      blocked: user['blocked'] ?? false,
      role_id: user['role']['id'],
      role_name: user['role']['name'],
      role_type: user['role']['type'],
      created_at: user['created_at'],
      updated_at: user['updated_at'],
    );
  }

  User.fromMap(Map<String, dynamic> user)
      : id = user['id'],
        username = user['username'],
        first_name = user['firstName'],
        last_name = user['lastName'],
        phone_number = user['phoneNumber'],
        home_address = user['homeAddress'],
        email = user['email'],
        provider = user['provider'],
        confirmed = user['confirmed'] ?? false,
        blocked = user['blocked'] ?? false,
        role_id = user['role']['id'],
        role_name = user['role']['name'],
        role_type = user['role']['type'],
        created_at = user['created_at'],
        updated_at = user['updated_at'];

  Map<String, Object> toMap() {
    return {
      'id': id,
      'username': username,
      'first_name': first_name,
      'last_name': last_name,
      'phone_number': phone_number,
      'home_address': home_address,
      'email': email,
      'provider': provider,
      'confirmed': confirmed,
      'blocked': blocked,
      'role_id': role_id,
      'role_name': role_name,
      'role_type': role_type,
      'created_at': created_at,
      'updated_at': updated_at,
    };
  }

  @override
  String toString() {
    // ignore: lines_longer_than_80_chars
    return 'id: ${id}, name: $username, email $email, roleName $role_name, provider $provider, role_type $role_type';
  }
}
