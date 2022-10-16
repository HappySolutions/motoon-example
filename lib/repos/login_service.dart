import 'package:motoon_api_example/models/login_req.dart';
import 'package:motoon_api_example/models/login_respon.dart';
import 'package:motoon_api_example/utilities/constants.dart';
import 'package:motoon_api_example/utilities/http_wrapper.dart';
import 'dart:convert';

class LoginSevice {
  String endPoint = "login";

  Future<LoginResponce> login(LoginRequest loginRequestModel) async {
    try {
      final response = await HttpWrapper().post(Constants.BASE_URL + endPoint,
          body: loginRequestModel.toJson());

      return LoginResponce.fromJson(json.decode(response));
    } catch (e) {
      throw Exception("Something wrong happened");
    }
  }
}
