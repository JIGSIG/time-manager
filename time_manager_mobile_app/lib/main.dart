import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:time_manager_mobile_app/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent,
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  setup();
  connectWithToken().then((value) => runApp(const MyApp()));
}
