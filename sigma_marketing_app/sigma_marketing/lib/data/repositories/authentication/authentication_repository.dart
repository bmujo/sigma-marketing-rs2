import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../datasources/remote/api_service.dart';
import '../../models/request/registration/new_profile.dart';
import '../base/base_repository.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository extends BaseRepository {
  ApiService get _apiService => ApiService(dio, baseUrl: endpoint);

  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    try {
      yield AuthenticationStatus.authenticated;
      yield* _controller.stream;
    } catch (_) {
      yield AuthenticationStatus.unauthenticated;
      yield* _controller.stream;
    }
  }

  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    const storage = FlutterSecureStorage();
    final result = await _apiService.signIn(username, password);
    if (result.token.isNotEmpty) {
      await storage.write(key: "token", value: result.token);
      await storage.write(key: "userId", value: result.userId.toString());
      _controller.add(AuthenticationStatus.authenticated);
    } else {
      _controller.add(AuthenticationStatus.unauthenticated);
    }
  }

  Future<void> create({
    required NewProfile newProfile,
  }) async {
    const storage = FlutterSecureStorage();
    final result = await _apiService.createInfluencerProfile(newProfile);
    if (result.token.isNotEmpty) {
      await storage.write(key: "token", value: result.token);
      await storage.write(key: "userId", value: result.userId.toString());
      _controller.add(AuthenticationStatus.authenticated);
    } else {
      _controller.add(AuthenticationStatus.unauthenticated);
    }
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
