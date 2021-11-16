import 'package:flutter/material.dart';
import 'package:time_manager_mobile_app/app.dart';
import 'package:time_manager_mobile_app/model/core/user_core.dart';
import 'package:time_manager_mobile_app/provider/auth_provider.dart';
import 'package:time_manager_mobile_app/view/admin_view/admin_home.dart';
import 'package:time_manager_mobile_app/view/manager_view/manager_home.dart';
import 'package:time_manager_mobile_app/view/user_view/user_home.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final provider = getIt<TmUserProvider>();

  TmUser? user;

  @override
  void initState() {
    user = provider.getUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (user?.role) {
      case "user":
        return const UserHome();
      case "manager":
        return const ManagerHome();
      case "admin":
        return const AdminHome();
      default:
        return const Scaffold(
          body: Center(
            child: Text("Not allowed"),
          ),
        );
    }
  }
}
