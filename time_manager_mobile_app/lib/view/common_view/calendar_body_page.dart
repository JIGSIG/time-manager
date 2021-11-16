import 'package:flutter/material.dart';
import 'package:time_manager_mobile_app/app.dart';
import 'package:time_manager_mobile_app/model/core/user_core.dart';
import 'package:time_manager_mobile_app/provider/auth_provider.dart';
import 'package:time_manager_mobile_app/view/admin_view/admin_calendar.dart';
import 'package:time_manager_mobile_app/view/manager_view/manager_calendar.dart';
import 'package:time_manager_mobile_app/view/user_view/user_calendar.dart';

class CalendarBody extends StatefulWidget {
  const CalendarBody({Key? key}) : super(key: key);

  @override
  _CalendarBodyState createState() => _CalendarBodyState();
}

class _CalendarBodyState extends State<CalendarBody> {
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
        return const UserCalendar();
      case "manager":
        return const ManagerCalendar();
      case "admin":
        return const AdminCalendar();
      default:
        return const Scaffold(
          body: Center(
            child: Text("Not allowed"),
          ),
        );
    }
  }
}
