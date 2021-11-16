import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:time_manager_mobile_app/model/core/clock_core.dart';
import 'package:time_manager_mobile_app/model/glitch/glitch.dart';
import 'package:time_manager_mobile_app/model/helper/clock_helper.dart';

class ClockProvider extends ChangeNotifier {
  final _helper = ClockHelper();
  final _streamController =
      StreamController<Either<Glitch, TmClock>>.broadcast();

  Stream<Either<Glitch, TmClock>> get clockStream {
    return _streamController.stream;
  }

  Future<void> setClock({required int userId}) async {
    final clockHelperResult = await _helper.setClock(userId);
    _streamController.add(clockHelperResult);
  }

  Future<void> getClock({required int userId}) async {
    final clockHelperResult = await _helper.getClock(userId);
    _streamController.add(clockHelperResult);
  }
}
