import 'package:motoon_api_example/models/user.dart';
import 'package:motoon_api_example/utilities/constants.dart';
import 'package:motoon_api_example/utilities/http_wrapper.dart';
import 'package:motoon_api_example/utilities/cache_wrapper.dart';
import 'dart:convert';

class Users {
  String endPoint = "users";
  Future<List<User>> getUsers() async {
    try {
      String? cachedUserData = await CacheWrapper().getUserData();
      Map<String, String> headers = {};
      if (cachedUserData != null) {
        Map<String, dynamic> cachedUserDataJson = jsonDecode(cachedUserData);
        if (cachedUserDataJson['data'] != null &&
            cachedUserDataJson['data']['Token'] != null) {
          headers['Authorization'] =
              "Bearer ${cachedUserDataJson['data']['Token']}";
        }
      }
      String response = await HttpWrapper()
          .get(Constants.BASE_URL + endPoint, headers: headers);
      Map jsonResponse = jsonDecode(response);
      Iterable usersIterable = jsonResponse['data'];
      List<User> usersList =
          usersIterable.map((jsonItem) => User.fromJson(jsonItem)).toList();
      return usersList;
    } catch (error) {
      //TODO: handle 401 case
      throw Exception("Something wrong happened");
    }
  }
}
