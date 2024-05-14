import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // Create storage
    const storage = FlutterSecureStorage();

    // Read value
    String? value = await storage.read(key: "token");
    if (value != null) {
      options.headers["Authorization"] = "Bearer $value";
    }
    return super.onRequest(options, handler);
  }
}