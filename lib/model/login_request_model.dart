class LoginRequestModel {
  LoginRequestModel({
    this.email,
    this.password,
  });

  String? email;
  String? password;

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) =>
      LoginRequestModel(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}
