import 'dart:async';

import 'package:flutter/material.dart';
import 'package:time_manager_mobile_app/app.dart';
import 'package:time_manager_mobile_app/model/core/user_core.dart';
import 'package:time_manager_mobile_app/provider/auth_provider.dart';
import 'package:time_manager_mobile_app/provider/team_provider.dart';

class ManagerHome extends StatefulWidget {
  const ManagerHome({Key? key}) : super(key: key);

  @override
  _ManagerHomeState createState() => _ManagerHomeState();
}

class _ManagerHomeState extends State<ManagerHome> {
  final List<TmUser> teamMembers = [];
  final managerProvider = getIt<TmUserProvider>();
  final provider = getIt<TeamProvider>();
  late final StreamSubscription<dynamic> streamSubscription;

  @override
  void initState() {
    super.initState();

    provider.getAllTeamMembers(userId: managerProvider.getUser!.id);
    streamSubscription = provider.teamStream.listen((snapshot) {
      snapshot.fold(
        (l) => null,
        (r) => null,
      );
      setState(() {});
    });
  }

  @override
  Future<void> dispose() async {
    streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) => const ListTile(
          trailing: PopUpMenu(),
        ),
        itemCount: teamMembers.length,
      ),
    );
  }
}

class PopUpMenu extends StatelessWidget {
  const PopUpMenu({Key? key}) : super(key: key);

  void showMenuSelection(String value) {
    print("pressed");
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      padding: EdgeInsets.zero,
      icon: const Icon(Icons.more_vert),
      onSelected: showMenuSelection,
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
            value: 'Create another',
            child: ListTile(
                leading: Icon(Icons.add), title: Text('Create another'))),
        const PopupMenuItem<String>(
            value: 'Delete',
            child: ListTile(leading: Icon(Icons.delete), title: Text('Delete')))
      ],
    );
  }
}
