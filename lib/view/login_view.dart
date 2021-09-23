import 'package:bloc_login/service/login_service.dart';
import 'package:bloc_login/view/viewdetail/login_view_detail.dart';
import 'package:bloc_login/viewmodel/login_cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  final GlobalKey<FormState> formkey = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String basePath = 'https://reqres.in/api';
  double paddingAllPage = 10.0;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(
          formkey, emailController, passwordController,
          service: LoginService(Dio(BaseOptions(baseUrl: basePath)))),
      child: BlocConsumer<LoginCubit, LoginState>(listener: (context, state) {
        if (state is LoginComplete) {
          state.navigate(context);
        }
      }, builder: (context, state) {
        return buildScaffold(formkey, context, state);
      }),
    );
  }

  Scaffold buildScaffold(GlobalKey<FormState> formkey, BuildContext context,
      LoginState loginState) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Form(
        autovalidateMode: loginState is LoginValidateState
            ? (loginState.isValidate
                ? AutovalidateMode.always
                : AutovalidateMode.disabled)
            : AutovalidateMode.disabled,
        key: formkey,
        child: Padding(
          padding: EdgeInsets.all(paddingAllPage),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildEmailForm(context),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              buildPasswordForm(context),
              ElevatedButton(
                onPressed: context.watch<LoginCubit>().isLoading
                    ? null
                    : () {
                        context.read<LoginCubit>().fetchLoginService();
                      },
                child: Text('save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: Visibility(
          visible: context.watch<LoginCubit>().isLoading,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          )),
    );
  }

  TextFormField buildPasswordForm(BuildContext context) {
    return TextFormField(
      controller: passwordController,
      obscureText: true,
      validator: (value) => (value ?? '').length > 5 ? null : '6dan küçük ',
      decoration:
          InputDecoration(border: OutlineInputBorder(), labelText: 'Password'),
    );
  }

  TextFormField buildEmailForm(BuildContext context) {
    return TextFormField(
      controller: emailController,
      validator: (value) => (value ?? '').length > 6 ? null : '6dan küçük ',
      decoration:
          InputDecoration(border: OutlineInputBorder(), labelText: 'Email'),
    );
  }
}

extension LoginCompleteExtension on LoginComplete {
  void navigate(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => LoginViewDetail(token: model),
    ));
  }
}
