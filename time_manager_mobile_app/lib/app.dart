import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:time_manager_mobile_app/model/core/user_core.dart';
import 'package:time_manager_mobile_app/provider/auth_provider.dart';
import 'package:time_manager_mobile_app/provider/clock_provider.dart';
import 'package:time_manager_mobile_app/provider/team_provider.dart';
import 'package:time_manager_mobile_app/provider/workingtimes_provider.dart';
import 'package:time_manager_mobile_app/view/common_view/authentication_page.dart';
import 'package:time_manager_mobile_app/view/home_page.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final provider = getIt<TmUserProvider>();
  TmUser? user;
  late final StreamSubscription<dynamic> streamSubscription;

  @override
  void initState() {
    setState(() {
      user = provider.getUser;
    });
    streamSubscription = provider.userStream.listen((snapshot) {
      snapshot.fold((l) {
        user = null;
      }, (r) => user = r);
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    streamSubscription.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: user != null ? const HomePage() : const AuthenticationPage(),
    );
  }
}

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<TmUserProvider>(TmUserProvider());
  getIt.registerSingleton<WorkingTimesProvider>(WorkingTimesProvider());
  getIt.registerSingleton<ClockProvider>(ClockProvider());
  getIt.registerSingleton<TeamProvider>(TeamProvider());
}

Future<void> connectWithToken() async {
  final provider = getIt<TmUserProvider>();
  await provider.checkTokenValidity();
}
