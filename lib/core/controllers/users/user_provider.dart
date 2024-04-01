import 'package:get/get_connect.dart';
import 'package:taxi_driver_app/core/api_backend_config.dart';
import 'package:taxi_driver_app/core/models/user/user_model.dart';

class UserProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = backendBaseUrl; // Replace with your backend URL
  }

  Future<Response<UserModel>> loginUser(LoginUserRequest request) => post(
        '/users/login',
        request.toJson(),
        // decoder: UserModel.fromJson,
      );
  Future<Response<List<UserModel>>> getAll() => get(
        '/users',
        // decoder: UserModel.fromMap(map),
      );
  Future<Response<UserModel>> getById(String id) => get(
        '/users/$id',
        // decoder: UserModel.fromJson,
      );

  Future<Response<UserModel>> create(UserModel user) => post(
        '/users',
        user.toJson(),
        // decoder: UserModel.fromJson,
      );
  Future<Response<UserModel>> update(UserModel user) => put(
        '/users/${user.user_id}',
        user.toJson(),
        // decoder: UserModel.fromJson,
      );
  Future<Response> remove(String userId) => delete(
        '/users/$userId',
      );
}
