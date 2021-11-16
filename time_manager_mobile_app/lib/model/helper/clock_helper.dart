import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:time_manager_mobile_app/model/core/clock_core.dart';
import 'package:time_manager_mobile_app/model/core/glitch_core.dart';
import 'package:time_manager_mobile_app/model/glitch/glitch.dart';
import 'package:time_manager_mobile_app/model/services/clock_services.dart';

class ClockHelper {
  final api = ClockApi();

  Future<Either<Glitch, TmClock>> setClock(int userId) async {
    final apiResult = await api.setClock(userId);
    return apiResult.fold((l) {
      return Left(NoInternetGlitch());
    }, (r) {
      var data = json.decode(r)["data"];
      TmClock clock =
          TmClock(time: DateTime(data["time"]), status: data["status"]);
      return Right(clock);
    });
  }

  Future<Either<Glitch, TmClock>> getClock(int userId) async {
    final apiResult = await api.getClock(userId);
    return apiResult.fold((l) {
      return Left(NoInternetGlitch());
    }, (r) {
      var data = json.decode(r)["data"];
      if (data == null) {
        return Left(NoInternetGlitch());
      }
      TmClock clock =
          TmClock(time: DateTime.parse(data["time"]), status: data["status"]);
      return Right(clock);
    });
  }
}
