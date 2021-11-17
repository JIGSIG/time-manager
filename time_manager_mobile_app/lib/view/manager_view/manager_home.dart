import 'dart:async';

import 'package:flutter/material.dart';
import 'package:time_manager_mobile_app/app.dart';
import 'package:time_manager_mobile_app/model/core/team_core.dart';
import 'package:time_manager_mobile_app/model/core/user_core.dart';
import 'package:time_manager_mobile_app/provider/auth_provider.dart';
import 'package:time_manager_mobile_app/provider/team_provider.dart';
import 'package:time_manager_mobile_app/view/home_page.dart';

class ManagerHome extends StatefulWidget {
  const ManagerHome({Key? key}) : super(key: key);

  @override
  _ManagerHomeState createState() => _ManagerHomeState();
}

class _ManagerHomeState extends State<ManagerHome> {
  TmTeam? team;
  final managerProvider = getIt<TmUserProvider>();
  final provider = getIt<TeamProvider>();
  late final StreamSubscription<dynamic> streamSubscription;

  int userToAddId = 1;

  bool loading = true;

  @override
  void initState() {
    super.initState();

    provider.getManagerTeam(userId: managerProvider.getUser!.id);
    streamSubscription = provider.teamStream.listen((snapshot) {
      snapshot.fold(
        (l) => null,
        (r) => team = r,
      );
      loading = false;
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
      child: loading
          ? const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Scaffold(
              body: team == null
                  ? const Center(
                      child: Text("No team for this manager"),
                    )
                  : TeamUIBuilder(
                      team: team!,
                    ),
              floatingActionButton: team == null
                  ? null
                  : FloatingActionButton(
                      child: const Icon(
                        Icons.add,
                        size: 30,
                      ),
                      backgroundColor: HexColor('#FFA400'),
                      onPressed: addUser,
                    ),
            ),
    );
  }

  void addUser() {
    _dismissDialog() {
      Navigator.pop(context);
    }

    final Size size = MediaQuery.of(context).size;
    final width = size.width;
    managerProvider.getAllUsers().then((value) {
      value.fold((l) => null, (r) {
        List<ListItem<TmUser>> list =
            List.generate(r.length, (index) => ListItem(r.elementAt(index)));
        list = list
            .where((element) =>
                team!.members.contains(element.data) == false &&
                team!.manager != element.data)
            .toList();
        double height = 60.0 * list.length;
        height = height > size.height ? size.height : height;
        showDialog(
          context: context,
          builder: (context) {
            return StatefulBuilder(builder: (context, setState) {
              return AlertDialog(
                title: const Text('Add User to Team'),
                contentPadding: const EdgeInsets.all(1),
                content: SizedBox(
                  height: height,
                  width: width * .9,
                  child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (_, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        child: ListTile(
                          selected: list[index].isSelected,
                          selectedTileColor: HexColor('#FFA400'),
                          title: Text(list[index].data.email),
                          trailing: const Icon(Icons.select_all),
                          onTap: () {
                            print('tap');
                            setState(() {
                              list[index].isSelected = !list[index].isSelected;
                              print(list[index].data.email);
                              print(list[index].isSelected);
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                      onPressed: () {
                        _dismissDialog();
                      },
                      child: const Text('Close')),
                  TextButton(
                    onPressed: () {
                      list
                          .where((element) => element.isSelected)
                          .forEach((element) {
                        provider.addUserToTeam(
                            teamId: team!.id, userId: element.data.id);
                      });
                      _dismissDialog();
                    },
                    child: const Text('Add!'),
                  )
                ],
              );
            });
          },
        );
      });
    });
  }
}

class ListItem<T> {
  bool isSelected = false; //Selection property to highlight or not
  T data; //Data of the user
  ListItem(this.data); //Constructor to assign the data
}

class PopUpMenu extends StatelessWidget {
  final int teamId;
  final int memberId;
  final bool isAdmin;

  const PopUpMenu(
      {Key? key,
      required this.teamId,
      required this.memberId,
      this.isAdmin = false})
      : super(key: key);

  void showMenuSelection(String value) {}

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      padding: EdgeInsets.zero,
      icon: const Icon(Icons.more_vert),
      onSelected: showMenuSelection,
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        if (isAdmin)
          const PopupMenuItem<String>(
            value: 'Promote',
            child: ListTile(
              leading: Icon(Icons.arrow_circle_up),
              title: Text('Promote User'),
            ),
          ),
        if (isAdmin)
          const PopupMenuItem<String>(
            value: 'Demote',
            child: ListTile(
              leading: Icon(Icons.arrow_circle_down),
              title: Text('Demote User'),
            ),
          ),
        PopupMenuItem<String>(
          value: 'Delete',
          child: const ListTile(
              leading: Icon(Icons.delete), title: Text('Delete')),
          onTap: () {
            final provider = getIt<TeamProvider>();
            provider.removeUserFromTeam(teamId: teamId, userId: memberId);
          },
        )
      ],
    );
  }
}

class TeamUIBuilder extends StatefulWidget {
  final TmTeam team;

  const TeamUIBuilder({Key? key, required this.team}) : super(key: key);

  @override
  _TeamBuilderUIState createState() => _TeamBuilderUIState();
}

class _TeamBuilderUIState extends State<TeamUIBuilder> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.team.name),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height * .1,
                width: width,
                child: Center(
                  child: ListTile(
                    title: Text(
                      widget.team.manager.username,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * .7,
                width: width,
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) => Center(
                    child: ListTile(
                      title: Text(
                        widget.team.members.elementAt(index).email,
                        textAlign: TextAlign.center,
                      ),
                      trailing: PopUpMenu(
                        teamId: widget.team.id,
                        memberId: widget.team.members.elementAt(index).id,
                      ),
                    ),
                  ),
                  itemCount: widget.team.members.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
