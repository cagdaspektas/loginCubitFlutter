import 'package:bloc_login/model/login_request_model.dart';
import 'package:bloc_login/model/login_response_model.dart';
import 'package:dio/dio.dart';

abstract class ILoginService {
  final Dio dio;

  ILoginService(this.dio);
  String path = ILoginServicePath.LOGIN.rawValue;

  Future<LoginResponseModel?> postLoginUser(LoginRequestModel model);
}

enum ILoginServicePath { LOGIN }

extension LoginServicePathExtension on ILoginServicePath {
  String get rawValue {
    switch (this) {
      case ILoginServicePath.LOGIN:
        return '/login';
    }
  }
}
