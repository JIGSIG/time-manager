import 'dart:async';
import 'dart:collection';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:time_manager_mobile_app/model/core/event_core.dart';
import 'package:time_manager_mobile_app/model/core/team_core.dart';
import 'package:time_manager_mobile_app/model/core/user_core.dart';
import 'package:time_manager_mobile_app/model/glitch/glitch.dart';
import 'package:time_manager_mobile_app/model/helper/calendar_helper.dart';

class WorkingTimesProvider extends ChangeNotifier {
  final _helper = CalendarHelper();
  final _streamController = StreamController<
      Either<Glitch, LinkedHashMap<DateTime, List<TmEvent>>>>.broadcast();

  Stream<Either<Glitch, LinkedHashMap<DateTime, List<TmEvent>>>>
      get workingTimesStream {
    return _streamController.stream;
  }

  Future<void> getAllWorkingTimes({required int userId}) async {
    final workingTimesHelperResult = await _helper.getWorkingTimes(userId);
    print(workingTimesHelperResult);
    _streamController.add(workingTimesHelperResult);
  }

  Future<void> getAllTeamMembersWorkingTimes({required TmTeam team}) async {
    getAllWorkingTimes(userId: team.manager.id);
    for (TmUser employee in team.members) {
      getAllWorkingTimes(userId: employee.id);
    }
  }
}
