import 'dart:convert';

import 'package:taxi_driver_app/core/api/api_constant.dart';
import 'package:taxi_driver_app/core/api/api_error_handler.dart';
import 'package:taxi_driver_app/core/api/api_response.dart';
import 'package:taxi_driver_app/core/models/user/user_model.dart';
import 'package:http/http.dart' as http;

class UserServices {
  static const serviceName = "users/";
  static const headers = {
    'Content-Type': 'application/json',
    "Accept": "application/json",
    "Access-Control_Allow_Origin": "*",
  };
  Future<APIResponse<LoginUserResponse>> loginUserFunction(
      LoginUserRequest loginUserRequest) async {
    Uri url = Uri.parse("$apiDomain/$serviceName/login");
    var res = await http.post(url,
        headers: headers,
        body: json.encode({
          'login': loginUserRequest.login,
          'password': loginUserRequest.password
        }));
    if (res.body.isNotEmpty && res.statusCode == 200) {
      Map response = json.decode(res.body);
      return APIResponse<LoginUserResponse>(
        data: response,
      );
    } else {
      ApiErrorHandler apiErrorHandler = ApiErrorHandler(
        res.statusCode.toString(),
        res.statusCode,
        res.body,
        res.headers,
        res.body,
      );
      var response = displayEror(errorHandler: apiErrorHandler, showTost: true);
      // return "Incorrect Username or Password";
      return APIResponse<LoginUserResponse>(
          data: null,
          error: true,
          errorMessage:
              "STATUS: ${response['errorCode']} \n BODY: ${response['errorBody']}");
    }
  }

  Future<APIResponse<List<UserModel>>> getAllUser() async {
    Uri url = Uri.parse("$apiDomain/$serviceName/get/all");
    return http.get(url).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(utf8.decode(data.bodyBytes));
        final users = <UserModel>[];
        for (var item in jsonData) {
          users.add(UserModel.fromJson(item));
        }
        return APIResponse<List<UserModel>>(
          data: users,
        );
      }
      return APIResponse<List<UserModel>>(
        error: true,
        errorMessage: data.body,
      );
    }).catchError((e) => APIResponse<List<UserModel>>(
          error: true,
          errorMessage: e.toString(),
        ));
  }

  Future<APIResponse<UserModel>> getOneUser(String userId) async {
    Uri url = Uri.parse("$apiDomain/$serviceName/get/one/$userId");
    return http.get(url).then((data) {
      return http.get(url).then((data) {
        if (data.statusCode == 200) {
          final jsonData = json.decode(utf8.decode(data.bodyBytes));
          var resturn = UserModel.fromJson(jsonData);
          return APIResponse<UserModel>(
            data: resturn,
          );
        }
        return APIResponse<UserModel>(
          error: true,
          errorMessage: url.toString(),
        );
      }).catchError((e) => APIResponse<UserModel>(
            error: true,
            errorMessage: "An error occured ",
          ));
    });
  }

  Future<APIResponse<bool>> createUser(CreateUserRequest item) async {
    Uri url = Uri.parse("$apiDomain$apiBaseUrl${serviceName}save");
    return http
        .post(url, headers: headers, body: jsonEncode(item.toJson()))
        .then((data) {
      if (data.statusCode == 201) {
        return APIResponse<bool>(
          data: true,
        );
      }
      return APIResponse<bool>(
        data: null,
        error: true,
        errorMessage: data.body,
      );
    }).catchError((e) => APIResponse<bool>(
              data: null,
              error: true,
              errorMessage: e.toString(),
            ));
  }

  Future<APIResponse<bool>> updatePassword(
      String userId, UpdatePasswordRequest item) async {
    Uri url =
        Uri.parse("$apiDomain$apiBaseUrl${serviceName}update/password/$userId");
    return http
        .put(url, headers: headers, body: jsonEncode(item.toJson()))
        .then((data) {
      if (data.statusCode == 200) {
        return APIResponse<bool>(
          data: true,
        );
      }
      if (data.statusCode == 400) {
        return APIResponse<bool>(
            data: data.statusCode.toString(), error: true, errorMessage: null);
      }
      return APIResponse<bool>(
        data: null,
        error: true,
        errorMessage: data.body,
      );
    }).catchError((e) => APIResponse<bool>(
              data: null,
              error: true,
              errorMessage: e.toString(),
            ));
  }

  // Future<APIResponse<bool>> updateUserInfo(
  //     String userId, UpdateUserRequest item) async {
  //   Uri url = Uri.parse("$apiDomain$apiBaseUrl${serviceName}update/$userId");
  //   return http
  //       .put(url, headers: headers, body: jsonEncode(item.toJson()))
  //       .then((data) {
  //     if (data.statusCode == 202) {
  //       final jsonData = json.decode(utf8.decode(data.bodyBytes));
  //       var resturn = ResponseUserRequest.allFromJson(jsonData);
  //       return APIResponse<bool>(
  //         data: resturn,
  //       );
  //     }
  //     if (data.statusCode == 500) {
  //       return APIResponse<bool>(
  //           data: data.statusCode.toString(), error: true, errorMessage: null);
  //     }
  //     return APIResponse<bool>(
  //       data: null,
  //       error: true,
  //       errorMessage: data.body,
  //     );
  //   }).catchError(
  //     (e) => APIResponse<bool>(
  //       data: null,
  //       error: true,
  //       errorMessage: e.toString(),
  //     ),
  //   );
  // }
}
