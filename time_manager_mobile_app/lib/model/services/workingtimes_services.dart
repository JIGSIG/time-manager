
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:time_manager_mobile_app/model/helper/api_call_helper.dart';

class WorkingTimesApi {
  ApiCallHelper apiCallHelper = ApiCallHelper();

  Future<Either<Exception, String>> getAllWorkingTimes(int userId) async {
    try {
      await apiCallHelper.init();
      String start = DateTime(DateTime.now().year).toIso8601String();
      String end = DateTime(DateTime.now().year + 1).toIso8601String();
      final uri = Uri.parse(
          apiCallHelper.getAllWorkingTimes + "/$userId?start=$start&end=$end");
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
