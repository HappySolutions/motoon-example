class LoginRequest {
  String? userName, password;

  LoginRequest({this.userName, this.password});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'userName': userName!.trim(),
      'password': password!.trim()
    };

    return map;
  }
}
