import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:time_manager_mobile_app/model/helper/api_call_helper.dart';

class AuthApi {
  ApiCallHelper apiCallHelper = ApiCallHelper();

  Future<Either<Exception, String>> checkTokenValidity(
      {required String? uid}) async {
    try {
      await apiCallHelper.init();
      final uri = Uri.parse(apiCallHelper.getUser + "/$uid");
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

  Future<Either<Exception, String>> signin(
      {required String email, required String password}) async {
    try {
      await apiCallHelper.init();
      final uri = Uri.parse(apiCallHelper.login);
      final body = {
        "email": email,
        "password_hash": password,
      };
      final response =
          await http.post(uri, headers: apiCallHelper.headers, body: json.encode(body));
      if (response.statusCode != 200) {
        throw Exception(response.body);
      }
      return Right(response.body);
    } catch (e) {
      Exception _l = Exception(e.toString());
      return (Left(_l));
    }
  }

  Future<Either<Exception, String>> signup(
      {required String username,
      required String email,
      required String password}) async {
    try {
      await apiCallHelper.init();
      final uri = Uri.parse(apiCallHelper.register);
      final body = {
        "username": username,
        "email": email,
        "password_hash": password,
      };
      final response =
          await http.post(uri, headers: apiCallHelper.headers, body: json.encode(body));
      return Right(response.body);
    } catch (e) {
      Exception _l = Exception(e.toString());
      return (Left(_l));
    }
  }

  Future<Either<Exception, String>> updateProfile(
      {required String email,
      required String username,
      required int id}) async {
    try {
      await apiCallHelper.init();
      final uri = Uri.parse(apiCallHelper.updateUser + "/$id");
      final body = {
        "username": username,
        "email": email,
      };
      final response =
          await http.put(uri, headers: apiCallHelper.headers, body: json.encode(body));
      return Right(response.body);
    } catch (e) {
      Exception _l = Exception(e.toString());
      return (Left(_l));
    }
  }

  Future<Either<Exception, String>> deleteProfile(
      {required String email,
      required String username,
      required int id}) async {
    try {
      await apiCallHelper.init();
      final uri = Uri.parse(apiCallHelper.updateUser + "/$id");
      final body = {
        "username": username,
        "email": email,
      };
      final response =
          await http.delete(uri, headers: apiCallHelper.headers, body: json.encode(body));
      return Right(response.body);
    } catch (e) {
      Exception _l = Exception(e.toString());
      return (Left(_l));
    }
  }

  Future<Either<Exception, String>> getAllUsers() async {
    try {
      await apiCallHelper.init();
      final uri = Uri.parse(apiCallHelper.getAllUsers);
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
