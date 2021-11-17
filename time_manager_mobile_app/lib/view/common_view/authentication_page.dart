import 'dart:async';

import 'package:flutter/material.dart';
import 'package:time_manager_mobile_app/app.dart';
import 'package:time_manager_mobile_app/model/core/user_core.dart';
import 'package:time_manager_mobile_app/provider/auth_provider.dart';
import 'package:time_manager_mobile_app/view/home_page.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  final provider = getIt<TmUserProvider>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  TmUser? user;

  String? message;

  bool loading = false;

  int tabIndex = 0;

  bool badInput = false;
  late final StreamSubscription<dynamic> streamSubscription;

  @override
  void initState() {
    streamSubscription = provider.userStream.listen((snapshot) {
      snapshot.fold((l) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error Login')),
        );
      }, (r) => null);
      loading = false;
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    streamSubscription.cancel();
    loading = false;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final bodyH = size.height * (badInput ? .5 : .425);
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        body: Stack(
          children: [
            Image.asset(
              'assets/batman.jpg',
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: size.height,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              badInput = false;
                              tabIndex = 0;
                            });
                          },
                          child: SizedBox(
                            height: size.height * .1,
                            width: size.width * .5,
                            child: Center(
                              child: Text(
                                "SIGN IN",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: (tabIndex == 0
                                        ? FontWeight.bold
                                        : null)),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              badInput = false;
                              tabIndex = 1;
                            });
                          },
                          child: SizedBox(
                            height: size.height * .1,
                            width: size.width * .5,
                            child: Center(
                              child: Text(
                                "SIGN UP",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: (tabIndex != 0
                                        ? FontWeight.bold
                                        : null)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: bodyH,
                      child: tabIndex == 0
                          ? LoginBody(
                              size: Size(size.width, bodyH),
                              emailController: emailController,
                              passwordController: passwordController,
                            )
                          : RegisterBody(
                              size: Size(size.width, bodyH),
                              usernameController: usernameController,
                              emailController: emailController,
                              passwordController: passwordController,
                              passwordConfirmController:
                                  passwordConfirmController,
                            ),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: HexColor('#FFA400'),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          textStyle: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        onPressed: onPressed,
                        child: Text(tabIndex == 0 ? "LOGIN" : "REGISTER"))
                  ],
                ),
              ),
            ),
            if (loading == true)
              const Center(child: CircularProgressIndicator())
          ],
        ),
      ),
    );
  }

  void onPressed() {
    badInput = _formKey.currentState!.validate() ? false : true;
    setState(() {});
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Incomplete data')),
      );
      return;
    }
    if (emailController.text == "" || passwordController.text == "") return;
    loading = true;
    setState(() {});
    if (tabIndex == 0) {
      provider.login(
        email: emailController.text,
        password: passwordController.text,
      );
    } else if (tabIndex == 1 &&
        passwordController.text == passwordConfirmController.text) {
      provider.register(
        username: usernameController.text,
        email: emailController.text,
        password: passwordController.text,
      );
    }
  }
}

class LoginBody extends StatefulWidget {
  final Size size;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginBody({
    Key? key,
    required this.size,
    required this.emailController,
    required this.passwordController,
  }) : super(key: key);

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.size.height,
      width: widget.size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            padding: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              color: Colors.black.withAlpha(175),
              border: Border.all(color: Colors.white54),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(Icons.email),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: TextFormField(
                      maxLines: 1,
                      controller: widget.emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        label: Text(" Email..."),
                        labelStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 17),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            padding: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              color: Colors.black.withAlpha(175),
              border: Border.all(color: Colors.white54),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(Icons.lock_outline),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: TextFormField(
                      maxLines: 1,
                      controller: widget.passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        label: Text(" Password..."),
                        labelStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 17),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RegisterBody extends StatefulWidget {
  final Size size;
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController passwordConfirmController;

  const RegisterBody({
    Key? key,
    required this.size,
    required this.usernameController,
    required this.emailController,
    required this.passwordController,
    required this.passwordConfirmController,
  }) : super(key: key);

  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.size.height,
      width: widget.size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            padding: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              color: Colors.black.withAlpha(175),
              border: Border.all(color: Colors.white54),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(Icons.person),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: TextFormField(
                      maxLines: 1,
                      controller: widget.usernameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        label: Text(" Username..."),
                        labelStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 17),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            padding: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              color: Colors.black.withAlpha(175),
              border: Border.all(color: Colors.white54),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(Icons.email),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: TextFormField(
                      maxLines: 1,
                      controller: widget.emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        label: Text(" Email..."),
                        labelStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 17),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            padding: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              color: Colors.black.withAlpha(175),
              border: Border.all(color: Colors.white54),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(Icons.lock_outline),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: TextFormField(
                      maxLines: 1,
                      controller: widget.passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        label: Text(" Password..."),
                        labelStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 17),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            padding: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              color: Colors.black.withAlpha(175),
              border: Border.all(color: Colors.white54),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(Icons.lock_outline),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: TextFormField(
                      maxLines: 1,
                      controller: widget.passwordConfirmController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        if (value != widget.passwordController.text) {
                          return 'Not identical';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        label: Text(" Confirm Password..."),
                        labelStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 17),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
