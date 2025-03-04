import 'package:flash_meet_frontend/core/model/either.dart';
import 'package:flash_meet_frontend/core/model/failure.dart';
import 'package:flash_meet_frontend/features/meet/domain/entity/meet_entity.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class MeetRepository {
  Future<Either<Failure, List<MeetEntity>>> getLastMeets(
      {int? page, int? limit});

  Future<Either<Failure, MeetEntity>> createMeet(
      {required String title,
      required String description,
      required TimeOfDay time,
      required LatLng location});

  Future<Either<Failure, MeetEntity>> getMeet(String meetId);

  Future<Either<Failure, void>> joinMeet(String meetId);

  Future<Either<Failure, List<MeetEntity>>> getMeets(
      double latitude, double longitude, double radius);

  Future<Either<Failure,List<MeetEntity>>> getCurrentMeets();

  Future<Either<Failure, void>> transferAdmin(String meetId, String newAdminId);

  Future<Either<Failure, void>> kickUser(String meetId, String userToKickId);

  Future<Either<Failure, void>> leaveMeet(String meetId);

  Future<Either<Failure, void>> cancelMeet(String meetId);
}
