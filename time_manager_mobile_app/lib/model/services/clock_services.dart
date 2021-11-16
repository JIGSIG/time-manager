import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:time_manager_mobile_app/model/helper/api_call_helper.dart';

class ClockApi {
  ApiCallHelper apiCallHelper = ApiCallHelper();

  Future<Either<Exception, String>> setClock(int userId) async {
    try {
      await apiCallHelper.init();
      final uri = Uri.parse(apiCallHelper.setClock + "/$userId");
      final response = await http.post(uri, headers: apiCallHelper.headers);
      if (response.statusCode != 200) {
        throw Exception(response.body);
      }
      return Right(response.body);
    } catch (e) {
      Exception _l = Exception(e.toString());
      return (Left(_l));
    }
  }

  Future<Either<Exception, String>> getClock(int userId) async {
    try {
      await apiCallHelper.init();
      final uri = Uri.parse(apiCallHelper.getClock + "/$userId");
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
}
