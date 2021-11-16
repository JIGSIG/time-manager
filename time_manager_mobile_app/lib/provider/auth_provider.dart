import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:time_manager_mobile_app/model/core/user_core.dart';
import 'package:time_manager_mobile_app/model/glitch/glitch.dart';
import 'package:time_manager_mobile_app/model/helper/auth_helper.dart';

class TmUserProvider extends ChangeNotifier {
  final _helper = TmUserHelper();
  final _streamController =
      StreamController<Either<Glitch, TmUser?>>.broadcast();

  TmUser? _tmUser;

  Stream<Either<Glitch, TmUser?>> get userStream {
    return _streamController.stream;
  }

  Future<void> checkTokenValidity() async {
    final tmUserHelperResult = await _helper.checkTokenValidity();
    _setUser(tmUserHelperResult);
    _streamController.add(tmUserHelperResult);
  }

  Future<void> login({required String email, required String password}) async {
    final tmUserHelperResult =
        await _helper.login(email: email, password: password);
    _setUser(tmUserHelperResult);
    _streamController.add(tmUserHelperResult);
  }

  Future<void> register({
    required String username,
    required String email,
    required String password,
  }) async {
    final tmUserHelperResult = await _helper.register(
        username: username, email: email, password: password);
    _setUser(tmUserHelperResult);
    _streamController.add(tmUserHelperResult);
  }

  void _setUser(Either<Glitch, TmUser?> result) {
    result.fold((l) => _tmUser = null, (r) => _tmUser = r);
  }

  TmUser? get getUser => _tmUser;

  Future<void> logout() async {
    final tmUserHelperResult = await _helper.logout();
    _setUser(tmUserHelperResult);
    _streamController.add(tmUserHelperResult);
  }

  Future<void> updateUsername({required String username}) async {
    print(runtimeType);
    final tmUserHelperResult = await _helper.update(
        username: username, email: _tmUser!.email, id: _tmUser!.id);
    _setUser(tmUserHelperResult);
    _streamController.add(tmUserHelperResult);
  }

  Future<void> deleteUser() async {
    final tmUserHelperResult = await _helper.delete(
        username: _tmUser!.username, email: _tmUser!.email, id: _tmUser!.id);
    _setUser(tmUserHelperResult);
    _streamController.add(tmUserHelperResult);
  }
}
