import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:time_manager_mobile_app/model/core/glitch_core.dart';
import 'package:time_manager_mobile_app/model/core/team_core.dart';
import 'package:time_manager_mobile_app/model/glitch/glitch.dart';
import 'package:time_manager_mobile_app/model/services/team_services.dart';

class TeamHelper {
  final api = TeamApi();

  Future<Either<Glitch, TmTeam>> getManagerTeam(int userId) async {
    final apiResult = await api.getManagerTeam(userId);
    return apiResult.fold((l) {
      return Left(NoInternetGlitch());
    }, (r) {
      var data = json.decode(r)["data"];
      TmTeam team = TmTeam.fromMap(data);
      return Right(team);
    });
  }

  Future<Either<Glitch, TmTeam>> addUserToTeam({required int teamId, required int userId}) async {
    final apiResult = await api.addUserToTeam(teamId: teamId, userId: userId);
    return apiResult.fold((l) {
      return Left(NoInternetGlitch());
    }, (r) {
      var data = json.decode(r)["data"];
      TmTeam team = TmTeam.fromMap(data);
      return Right(team);
    });
  }

  Future<Either<Glitch, TmTeam>> removeUserFromTeam({required int teamId, required int userId}) async {
    final apiResult = await api.removeUserFromTeam(teamId: teamId, userId: userId);
    return apiResult.fold((l) {
      return Left(NoInternetGlitch());
    }, (r) {
      var data = json.decode(r)["data"];
      TmTeam team = TmTeam.fromMap(data);
      return Right(team);
    });
  }
}
