import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:time_manager_mobile_app/model/core/user_core.dart';
import 'package:time_manager_mobile_app/model/glitch/glitch.dart';
import 'package:time_manager_mobile_app/model/helper/calendar_helper.dart';
import 'package:time_manager_mobile_app/model/helper/team_helper.dart';

class TeamProvider extends ChangeNotifier {
  final _helper = TeamHelper();
  final _streamController =
      StreamController<Either<Glitch, List<TmUser>>>.broadcast();

  Stream<Either<Glitch, List<TmUser>>> get teamStream {
    return _streamController.stream;
  }

  Future<void> getAllTeamMembers({required int userId}) async {
    final teamHelperResult = await _helper.getAllTeamMembers(userId);
    _streamController.add(teamHelperResult);
  }
}
