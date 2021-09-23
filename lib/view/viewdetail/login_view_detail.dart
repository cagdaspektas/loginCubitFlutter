import 'package:bloc_login/model/login_response_model.dart';
import 'package:flutter/material.dart';

class LoginViewDetail extends StatefulWidget {
  const LoginViewDetail({Key? key, required this.token}) : super(key: key);
  final LoginResponseModel token;

  @override
  _LoginViewDetailState createState() => _LoginViewDetailState();
}

class _LoginViewDetailState extends State<LoginViewDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(widget.token.token.toString()),
      ),
    );
  }
}
