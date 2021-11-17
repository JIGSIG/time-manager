import 'package:shared_preferences/shared_preferences.dart';

class ApiCallHelper {
  ApiCallHelper();

  SharedPreferences? sharedPreferences;

  final String endpoint = "http://192.168.100.3:4000/api";

  String get login => endpoint + "/registration/signin";

  String get register => endpoint + "/registration/signup";

  String get getAllWorkingTimes => endpoint + "/workingtimes";

  String get getManagerTeam => endpoint + "/teams/showManagerTeam";

  String get addTeamMember => endpoint + "/teams/adduser";

  String get removeTeamMember => endpoint + "/teams/removeuser";

  String get setClock => endpoint + "/clocks";

  String get getClock => endpoint + "/clocks";

  String get getUser => endpoint + "/users";

  String get getAllUsers => endpoint + "/users";

  String get updateUser => endpoint + "/users";

  String get deleteUser => endpoint + "/users";

  Map<String, String>? get headers => {
        "Authorization": "Bearer " + _getUserToken(),
        'Content-Type': 'application/json',
      };

  String _getUserToken() {
    return sharedPreferences!.getString("user-token") ?? "";
  }

  init() async {
    if (sharedPreferences != null) return;
    sharedPreferences = await SharedPreferences.getInstance();
  }
}
