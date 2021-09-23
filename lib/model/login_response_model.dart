class LoginResponseModel {
  LoginResponseModel({
    this.token,
  });

  String? token;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
      };
}
