import 'dart:collection';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:time_manager_mobile_app/model/core/event_core.dart';
import 'package:time_manager_mobile_app/model/core/glitch_core.dart';
import 'package:time_manager_mobile_app/model/glitch/glitch.dart';
import 'package:time_manager_mobile_app/model/services/workingtimes_services.dart';

class CalendarHelper {
  final api = WorkingTimesApi();

  Future<Either<Glitch, LinkedHashMap<DateTime, List<TmEvent>>>>
      getWorkingTimes(int userId) async {
    final apiResult = await api.getAllWorkingTimes(userId);
    return apiResult.fold((l) {
      return Left(NoInternetGlitch());
    }, (r) {
      final List dataset = json.decode(r)["data"];
      final LinkedHashMap<DateTime, List<TmEvent>> _kEventSource =
          LinkedHashMap<DateTime, List<TmEvent>>();
      for (var item in dataset) {
        DateTime key = DateTime.utc(
            DateTime.parse(item["start"]).year,
            DateTime.parse(item["start"]).month,
            DateTime.parse(item["start"]).day);
        List<TmEvent> value = [];
        for (Map<String, dynamic> data in dataset) {
          DateTime tmpA = DateTime.parse(data["start"]);
          DateTime tmpB = DateTime.parse(item["start"]);
          DateTime a = DateTime(tmpA.year, tmpA.month, tmpA.day);
          DateTime b = DateTime(tmpB.year, tmpB.month, tmpB.day);
          if (isSameDay(a, b)) {
            value.add(TmEvent(
              "Event ${data["id"]}",
              DateTimeRange(
                start: DateTime.parse(data["start"]),
                end: DateTime.parse(data["end"]),
              ),
            ));
          }
        }
        _kEventSource.addAll({key: value});
      }
      return Right(_kEventSource);
    });
  }
}
