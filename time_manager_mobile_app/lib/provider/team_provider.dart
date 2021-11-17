import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:time_manager_mobile_app/model/core/team_core.dart';
import 'package:time_manager_mobile_app/model/glitch/glitch.dart';
import 'package:time_manager_mobile_app/model/helper/team_helper.dart';

class TeamProvider extends ChangeNotifier {
  final _helper = TeamHelper();
  final _streamController =
      StreamController<Either<Glitch, TmTeam>>.broadcast();

  TmTeam? _tmTeam;

  TmTeam? get getTeam => _tmTeam;

  Stream<Either<Glitch, TmTeam>> get teamStream {
    return _streamController.stream;
  }

  void _setTeam(Either<Glitch, TmTeam?> result) {
    result.fold((l) => _tmTeam = null, (r) => _tmTeam = r);
  }

  Future<void> getManagerTeam({required int userId}) async {
    final teamHelperResult = await _helper.getManagerTeam(userId);
    _setTeam(teamHelperResult);
    _streamController.add(teamHelperResult);
  }

  Future<void> addUserToTeam({required int teamId, required int userId}) async {
    final teamHelperResult = await _helper.addUserToTeam(teamId: teamId, userId: userId);
    _setTeam(teamHelperResult);
    _streamController.add(teamHelperResult);
  }

  Future<void> removeUserFromTeam({required int teamId, required int userId}) async {
    final teamHelperResult = await _helper.removeUserFromTeam(teamId: teamId, userId: userId);
    _setTeam(teamHelperResult);
    _streamController.add(teamHelperResult);
  }
}
