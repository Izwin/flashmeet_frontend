import 'dart:io';

import 'package:flash_meet_frontend/core/model/either.dart';
import 'package:flash_meet_frontend/core/model/failure.dart';
import 'package:flash_meet_frontend/features/auth/domain/entity/user_entity.dart';

abstract class UserRepository {
  Future<Either<Failure, UserEntity>> getUser();

  Future<Either<Failure, void>> editUser(
      {required String name, required String bio, File? avatar});
}
