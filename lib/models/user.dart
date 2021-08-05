class User {
  int id;
  String username;
  String email;
  String provider;
  bool confirmed;
  var blocked = false;
  int role_id;
  String role_name;
  String role_type;
  String created_at;
  String updated_at;
  String jwt;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.provider,
    required this.confirmed,
    required this.blocked,
    required this.role_id,
    required this.role_name,
    required this.role_type,
    required this.created_at,
    required this.updated_at,
    required this.jwt,
  });

  factory User.fromJson(Map<String, dynamic> user) {
    return User(
      jwt: user['jwt'],
      id: user['user']['id'],
      username: user['user']['username'],
      email: user['user']['email'],
      provider: user['user']['provider'],
      confirmed: user['user']['confirmed'],
      blocked: user['user']['blocked'] ?? false,
      role_id: user['user']['role']['id'],
      role_name: user['user']['role']['name'],
      role_type: user['user']['role']['type'],
      created_at: user['user']['created_at'],
      updated_at: user['user']['updated_at'],
    );
  }

  User.fromMap(Map<String, dynamic> user)
      : jwt = user['jwt'],
        id = user['user']['id'],
        username = user['user']['username'],
        email = user['user']['email'],
        provider = user['user']['provider'],
        confirmed = user['user']['confirmed'],
        blocked = user['user']['blocked'] ?? false,
        role_id = user['user']['role']['id'],
        role_name = user['user']['role']['name'],
        role_type = user['user']['role']['type'],
        created_at = user['user']['created_at'],
        updated_at = user['user']['updated_at'];

  Map<String, Object> toMap() {
    return {
      'jwt': jwt,
      'id': id,
      'username': username,
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
