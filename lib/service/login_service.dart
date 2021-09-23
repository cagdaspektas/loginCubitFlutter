import 'dart:io';

import 'package:bloc_login/model/login_response_model.dart';
import 'package:bloc_login/model/login_request_model.dart';
import 'package:bloc_login/service/ilogin_service.dart';
import 'package:dio/src/dio.dart';

class LoginService extends ILoginService {
  LoginService(Dio dio) : super(dio);

  @override
  Future<LoginResponseModel?> postLoginUser(LoginRequestModel model) async {
    final response = await dio.post(path, data: model);

    if (response.statusCode == HttpStatus.ok) {
      return LoginResponseModel.fromJson(response.data);
    } else {
      return null;
    }
  }
}
