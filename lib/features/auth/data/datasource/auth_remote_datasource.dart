import 'package:dio/dio.dart';
import 'package:flash_meet_frontend/features/auth/domain/entity/user_entity.dart';

class AuthRemoteDatasource{
  final Dio dio;

  AuthRemoteDatasource({required this.dio});

  Future<UserEntity> signInWithGoogle(String token) async {
    var request = await dio.post('users/auth',data: {
      'token' : token
    });

    return UserEntity.fromJson(request.data);
  }
}