class LoginResponce {
  final String token, error;

  LoginResponce({required this.token, required this.error});

  factory LoginResponce.fromJson(Map<String, dynamic> json) {
    return LoginResponce(
        token: json['token'] != null ? json['token'] : '',
        error: json['error'] != null ? json['error'] : '');
  }
}
