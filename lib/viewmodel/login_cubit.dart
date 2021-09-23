import 'package:bloc/bloc.dart';
import 'package:bloc_login/model/login_request_model.dart';
import 'package:bloc_login/model/login_response_model.dart';
import 'package:bloc_login/service/ilogin_service.dart';
import 'package:flutter/material.dart';

class LoginCubit extends Cubit<LoginState> {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formkey;
  bool isLoginFail = false;
  bool isLoading = false;

  final ILoginService service;

  LoginCubit(this.formkey, this.emailController, this.passwordController,
      {required this.service})
      : super(LoginInitial());

  Future<void> fetchLoginService() async {
    if (formkey.currentState!.validate() && formkey.currentState != null) {
      changeLoading();
      final data = await service.postLoginUser(
        LoginRequestModel(
            email: emailController.text.trim(),
            password: passwordController.text.trim()),
      );
      changeLoading();
      if (data is LoginResponseModel) {
        emit(LoginComplete(data));
      }
    } else {
      isLoginFail = true;
      emit(LoginValidateState(isLoginFail));
    }
  }

  void changeLoading() {
    isLoading = !isLoading;
    emit(LoginIsLoading(isLoading));
  }
}

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginComplete extends LoginState {
  final LoginResponseModel model;

  LoginComplete(this.model);
}

class LoginValidateState extends LoginState {
  final bool isValidate;

  LoginValidateState(this.isValidate);
}

class LoginIsLoading extends LoginState {
  final bool isLoading;

  LoginIsLoading(this.isLoading);
}
