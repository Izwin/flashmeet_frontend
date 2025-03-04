import 'package:flash_meet_frontend/core/model/either.dart';
import 'package:flash_meet_frontend/core/model/failure.dart';
import 'package:flash_meet_frontend/features/auth/domain/entity/user_entity.dart';

abstract class AuthRepository{
  Future<Either<Failure,UserEntity>> signInWithGoogle();
  Future<Either<Failure,void>> logOut();
}