import 'package:dartz/dartz.dart';
import 'package:time_manager_mobile_app/model/core/glitch_core.dart';
import 'package:time_manager_mobile_app/model/core/user_core.dart';
import 'package:time_manager_mobile_app/model/glitch/glitch.dart';
import 'package:time_manager_mobile_app/model/services/team_services.dart';

class TeamHelper {
  final api = TeamApi();

  Future<Either<Glitch, List<TmUser>>> getAllTeamMembers(int userId) async {
    final apiResult = await api.getAllTeamMembers(userId);
    return apiResult.fold((l) {
      return Left(NoInternetGlitch());
    }, (r) {
      return const Right([]);
    });
  }
}
