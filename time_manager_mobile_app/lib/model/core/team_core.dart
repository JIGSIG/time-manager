import 'dart:convert';

import 'package:time_manager_mobile_app/app.dart';
import 'package:time_manager_mobile_app/model/core/user_core.dart';
import 'package:time_manager_mobile_app/provider/auth_provider.dart';

class TmTeam {
  final int id;
  final TmUser manager;
  final String name;
  final List<TmUser> members;

  const TmTeam({
    required this.id,
    required this.manager,
    required this.name,
    required this.members,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'manager': manager.toMap(),
      'name': name,
      'members': List<Map<String, dynamic>>.generate(members.length, (index) => members.elementAt(index).toMap()),
    };
  }

  static TmTeam fromMap(Map<String, dynamic> map) {
    return TmTeam(
      id: map['id'],
      manager: getIt<TmUserProvider>().getUser!,
      name: map['name'],
      members: List<TmUser>.generate(map['members'].length, (index) => TmUser.fromMap(map['members'][index])),
    );
  }

  String toJson() => json.encode(toMap());

  static TmTeam fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'TmTeam(id: $id, manager: $manager, name: $name, members: $members)';
  }
}
