import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:time_manager_mobile_app/app.dart';
import 'package:time_manager_mobile_app/model/core/user_core.dart';
import 'package:time_manager_mobile_app/provider/auth_provider.dart';
import 'package:time_manager_mobile_app/view/common_view/calendar_body_page.dart';
import 'package:time_manager_mobile_app/view/common_view/dashboard_body_page.dart';
import 'package:time_manager_mobile_app/view/common_view/home_body_page.dart';
import 'package:time_manager_mobile_app/view/common_view/logout_page.dart';
import 'package:time_manager_mobile_app/view/common_view/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final autoSizeGroup = AutoSizeGroup();
  var _bottomNavIndex = 4;

  late AnimationController _animationController;
  late Animation<double> animation;
  late CurvedAnimation curve;

  final iconList = <IconData>[
    Icons.calendar_today_rounded,
    Icons.dashboard,
    Icons.person_outlined,
    Icons.logout,
  ];

  final provider = getIt<TmUserProvider>();

  TmUser? user;

  @override
  void initState() {
    user = provider.getUser;
    bottomNavBarInit();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        body: homeBody(),
        floatingActionButton: ScaleTransition(
          scale: animation,
          child: FloatingActionButton(
            elevation: 8,
            backgroundColor: HexColor('#FFA400'),
            splashColor: HexColor('#FFA400'),
            child: Icon(
              Icons.home_rounded,
              color: HexColor('#373A36'),
              size: 30,
            ),
            onPressed: () {
              _bottomNavIndex = 4;
              _animationController.reset();
              _animationController.forward();
              setState(() {});
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: AnimatedBottomNavigationBar.builder(
          itemCount: iconList.length,
          tabBuilder: (int index, bool isActive) {
            return _homeNavbarIcons(index, isActive);
          },
          backgroundColor: HexColor('#373A36'),
          activeIndex: _bottomNavIndex,
          splashColor: HexColor('#FFA400'),
          splashSpeedInMilliseconds: 300,
          notchSmoothness: NotchSmoothness.defaultEdge,
          gapLocation: GapLocation.center,
          leftCornerRadius: 32,
          rightCornerRadius: 32,
          onTap: (index) {
            if (index == 3) {
              _dismissDialog() {
                Navigator.pop(context);
              }

              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Disconnect'),
                    content: const Text('Are you sure ?!'),
                    actions: <Widget>[
                      TextButton(
                          onPressed: () {
                            _dismissDialog();
                          },
                          child: const Text('Close')),
                      TextButton(
                        onPressed: () {
                          provider.logout();
                          _dismissDialog();
                        },
                        child: const Text('Yes!'),
                      )
                    ],
                  );
                },
              );
              return;
            }
            setState(() => _bottomNavIndex = index);
          },
        ),
      ),
    );
  }

  void bottomNavBarInit() {
    final systemTheme = SystemUiOverlayStyle.light.copyWith(
      systemNavigationBarColor: HexColor('#373A36'),
      systemNavigationBarIconBrightness: Brightness.light,
    );
    SystemChrome.setSystemUIOverlayStyle(systemTheme);

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    curve = CurvedAnimation(
      parent: _animationController,
      curve: const Interval(
        0.5,
        1.0,
        curve: Curves.easeInSine,
      ),
    );
    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(curve);

    Future.delayed(
      const Duration(milliseconds: 100),
      () => _animationController.forward(),
    );
  }

  homeBody() {
    switch (_bottomNavIndex) {
      case 0:
        return const CalendarBody();
      case 1:
        return const DashboardBody();
      case 2:
        return const ProfilePage();
      case 3:
        return const LogoutPage();
      case 4:
        return const HomeBody();
    }
    setState(() {});
  }

  Widget _homeNavbarIcons(int index, bool isActive) {
    final color = isActive ? HexColor('#FFA400') : Colors.white;

    String getTabName() {
      switch (index) {
        case 0:
          return "calendar";
        case 1:
          return "dashboard";
        case 2:
          return "profile";
        case 3:
          return "logout";
        default:
          return "Home";
      }
    }

    String tabName = getTabName();

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          iconList[index],
          size: 24,
          color: color,
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: AutoSizeText(
            tabName,
            maxLines: 1,
            style: TextStyle(color: color),
            group: autoSizeGroup,
          ),
        )
      ],
    );
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
