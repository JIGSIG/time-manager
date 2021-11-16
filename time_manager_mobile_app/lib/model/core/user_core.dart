import 'dart:convert';

class TmUser {
  final int id;
  final String email;
  final String username;
  final String role;

  const TmUser({
    required this.id,
    required this.email,
    required this.username,
    required this.role,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'role': role,
    };
  }

  static TmUser fromMap(Map<String, dynamic> map) {
    return TmUser(
      id: map['id'],
      email: map['email'],
      username: map['username'],
      role: map['role'],
    );
  }

  String toJson() => json.encode(toMap());

  static TmUser fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'TmUser(id: $id, email: $email, username: $username, role: $role)';
  }
}
