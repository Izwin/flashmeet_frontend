import 'package:dio/dio.dart';
import 'package:flash_meet_frontend/core/model/either.dart';
import 'package:flash_meet_frontend/core/model/failure.dart';
import 'package:flash_meet_frontend/features/meet/data/datasource/meet_remote_datasource.dart';
import 'package:flash_meet_frontend/features/meet/domain/entity/meet_entity.dart';
import 'package:flash_meet_frontend/features/meet/domain/repository/meet_repository.dart';
import 'package:flutter/src/material/time.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';

class MeetRepositoryImpl implements MeetRepository {
  final MeetRemoteDatasource meetRemoteDatasource;

  MeetRepositoryImpl({required this.meetRemoteDatasource});

  @override
  Future<Either<Failure, List<MeetEntity>>> getLastMeets(
      {int? page, int? limit}) async {
    try {
      return Right(
          await meetRemoteDatasource.getLastMeets(page: page, limit: limit));
    } on DioException catch (e) {
      return Left(MeetFailure(message: e.response?.data['message']));
    } catch (e) {
      return Left(MeetFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, MeetEntity>> createMeet(
      {required String title,
      required String description,
      required TimeOfDay time,
      required LatLng location}) async {
    try {
      return Right(await meetRemoteDatasource.createMeet(
          title: title,
          description: description,
          time: time,
          location: location));
    } on DioException catch (e) {
      return Left(MeetFailure(message: e.response?.data['message']));
    } catch (e) {
      return Left(MeetFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, MeetEntity>> getMeet(String meetId) async {
    try {
      return Right(await meetRemoteDatasource.getMeet(meetId));
    } on DioException catch (e) {
      return Left(MeetFailure(message: e.response?.data['message']));
    } catch (e) {
      return Left(MeetFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> joinMeet(String meetId) async {
    try {
      return Right(await meetRemoteDatasource.joinMeet(meetId));
    } on DioException catch (e) {
      return Left(MeetFailure(message: e.response?.data['message']));
    } catch (e) {
      return Left(MeetFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> kickUser(
      String meetId, String userToKickId) async {
    try {
      return Right(await meetRemoteDatasource.kickUser(meetId, userToKickId));
    } on DioException catch (e) {
      return Left(MeetFailure(message: e.response?.data['message']));
    } catch (e) {
      return Left(MeetFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> transferAdmin(
      String meetId, String newAdminId) async {
    try {
      return Right(
          await meetRemoteDatasource.transferAdmin(meetId, newAdminId));
    } on DioException catch (e) {
      return Left(MeetFailure(message: e.response?.data['message']));
    } catch (e) {
      return Left(MeetFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> cancelMeet(String meetId) async {
    try {
      return Right(await meetRemoteDatasource.cancelMeet(meetId));
    } on DioException catch (e) {
      return Left(MeetFailure(message: e.response?.data['message']));
    } catch (e) {
      return Left(MeetFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> leaveMeet(String meetId) async {
    try {
      return Right(await meetRemoteDatasource.leaveMeet(meetId));
    } on DioException catch (e) {
      return Left(MeetFailure(message: e.response?.data['message']));
    } catch (e) {
      return Left(MeetFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MeetEntity>>> getMeets(
      double latitude, double longitude, double radius) async {
    try {
      return Right(
          await meetRemoteDatasource.getMeets(latitude, longitude, radius));
    } on DioException catch (e) {
      return Left(MeetsFailure(message: e.response?.data['message']));
    } catch (e) {
      return Left(MeetsFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MeetEntity>>> getCurrentMeets() async {
    try{
      return Right(await meetRemoteDatasource.getCurrentMeets());
    }
    on DioException catch (e){
      return Left(MeetsFailure(message: e.response?.data['message']));
    }
    catch (e){
      return Left(MeetsFailure(message: e.toString()));
    }
  }
}
