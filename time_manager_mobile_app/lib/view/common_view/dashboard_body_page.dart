import 'package:flutter/material.dart';
import 'package:time_manager_mobile_app/app.dart';
import 'package:time_manager_mobile_app/model/core/user_core.dart';
import 'package:time_manager_mobile_app/provider/auth_provider.dart';
import 'package:time_manager_mobile_app/view/admin_view/admin_dashboard.dart';
import 'package:time_manager_mobile_app/view/manager_view/manager_dashboard.dart';
import 'package:time_manager_mobile_app/view/user_view/user_dashboard.dart';

class DashboardBody extends StatefulWidget {
  const DashboardBody({Key? key}) : super(key: key);

  @override
  _DashboardBodyState createState() => _DashboardBodyState();
}

class _DashboardBodyState extends State<DashboardBody> {
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
        return const UserDashboard();
      case "manager":
        return const ManagerDashboard();
      case "admin":
        return const AdminDashboard();
      default:
        return const Scaffold(
          body: Center(
            child: Text("Not allowed"),
          ),
        );
    }
  }
}
