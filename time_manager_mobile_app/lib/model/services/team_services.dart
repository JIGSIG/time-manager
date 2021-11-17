import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:time_manager_mobile_app/model/helper/api_call_helper.dart';

class TeamApi {
  ApiCallHelper apiCallHelper = ApiCallHelper();

  Future<Either<Exception, String>> getManagerTeam(int userId) async {
    try {
      await apiCallHelper.init();
      final uri = Uri.parse(apiCallHelper.getManagerTeam + "/$userId");
      final response = await http.get(uri, headers: apiCallHelper.headers);
      if (response.statusCode != 200) {
        throw Exception(response.body);
      }
      return Right(response.body);
    } catch (e) {
      Exception _l = Exception(e.toString());
      return (Left(_l));
    }
  }

  Future<Either<Exception, String>> addUserToTeam({required int teamId, required int userId}) async {
    try {
      await apiCallHelper.init();
      final uri = Uri.parse(apiCallHelper.addTeamMember + "/$teamId");
      final body = {
        "teams": {
          "new_member": userId
        },
      };
      final response = await http.put(uri, headers: apiCallHelper.headers, body: json.encode(body));
      if (response.statusCode != 200) {
        throw Exception(response.body);
      }
      return Right(response.body);
    } catch (e) {
      Exception _l = Exception(e.toString());
      return (Left(_l));
    }
  }

  Future<Either<Exception, String>> removeUserFromTeam({required int teamId, required int userId}) async {
    try {
      await apiCallHelper.init();
      final uri = Uri.parse(apiCallHelper.removeTeamMember + "/$teamId");
      final body = {
        "teams": {
          "old_member": userId
        },
      };

      final response = await http.put(uri, headers: apiCallHelper.headers, body: json.encode(body));
      if (response.statusCode != 200) {
        throw Exception(response.body);
      }
      return Right(response.body);
    } catch (e) {
      Exception _l = Exception(e.toString());
      return (Left(_l));
    }
  }
}
