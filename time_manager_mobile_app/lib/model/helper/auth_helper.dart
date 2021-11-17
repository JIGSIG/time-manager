import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_manager_mobile_app/model/core/glitch_core.dart';
import 'package:time_manager_mobile_app/model/core/user_core.dart';
import 'package:time_manager_mobile_app/model/glitch/glitch.dart';
import 'package:time_manager_mobile_app/model/services/auth_service.dart';

class TmUserHelper {
  final api = AuthApi();

  Future<Either<Glitch, TmUser>> checkTokenValidity() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    String? uid = preferences.getString("user-id");
    final apiResult = await api.checkTokenValidity(uid: uid);
    return apiResult.fold((l) {
      return Left(NoInternetGlitch());
    }, (r) {
      final user = TmUser.fromMap(jsonDecode(r)["data"]);
      return Right(user);
    });
  }

  Future<Either<Glitch, TmUser>> login(
      {required String email, required String password}) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final apiResult = await api.signin(email: email, password: password);
    return apiResult.fold((l) {
      return Left(NoInternetGlitch());
    }, (r) {
      final String token = jsonDecode(r)["token"];
      preferences.setString("user-token", token);
      final user = TmUser.fromMap(jsonDecode(r)["user"]);
      preferences.setString("user-id", user.id.toString());
      return Right(user);
    });
  }

  Future<Either<Glitch, TmUser>> register({
    required String username,
    required String email,
    required String password,
  }) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final apiResult =
        await api.signup(email: email, password: password, username: username);
    return apiResult.fold((l) {
      return Left(NoInternetGlitch());
    }, (r) {
      final String token = jsonDecode(r)["token"];
      preferences.setString("user-token", token);
      final user = TmUser.fromMap(jsonDecode(r)["user"]);
      preferences.setString("user-id", user.id.toString());
      return Right(user);
    });
  }

  Future<Either<Glitch, TmUser?>> logout() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    Either<Glitch, TmUser?> bad() {
      try {
        return const Right(null);
      } catch (e) {
        return Left(NoInternetGlitch());
      }
    }

    final apiResult = bad();
    return apiResult.fold((l) {
      preferences.remove("user-token");
      preferences.remove("user-id");
      return Left(NoInternetGlitch());
    }, (r) {
      preferences.remove("user-token");
      preferences.remove("user-id");
      return const Right(null);
    });
  }

  Future<Either<Glitch, TmUser>> update(
      {required String username,
      required String email,
      required int id}) async {
    final apiResult =
        await api.updateProfile(email: email, username: username, id: id);
    return apiResult.fold((l) {
      return Left(NoInternetGlitch());
    }, (r) {
      final user = TmUser.fromMap(jsonDecode(r)["data"]);
      return Right(user);
    });
  }

  Future<Either<Glitch, TmUser?>> delete(
      {required String username,
      required String email,
      required int id}) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final apiResult =
        await api.deleteProfile(email: email, username: username, id: id);
    return apiResult.fold((l) {
      return Left(NoInternetGlitch());
    }, (r) {
      preferences.remove("user-token");
      preferences.remove("user-id");
      return const Right(null);
    });
  }

  Future<Either<Glitch, List<TmUser>>> getAllUsers() async {
    final apiResult = await api.getAllUsers();
    return apiResult.fold((l) {
      return Left(NoInternetGlitch());
    }, (r) {
      List data = jsonDecode(r)["data"];
      final List<TmUser> list = List.generate(
        data.length,
        (index) => TmUser.fromMap(
          data.elementAt(index),
        ),
      );
      return Right(list);
    });
  }
}
