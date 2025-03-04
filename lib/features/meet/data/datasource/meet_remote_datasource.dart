import 'package:dio/dio.dart';
import 'package:flash_meet_frontend/features/meet/domain/entity/meet_entity.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MeetRemoteDatasource {
  final Dio dio;

  MeetRemoteDatasource({required this.dio});

  Future<List<MeetEntity>> getLastMeets({int? page, int? limit}) async {
    var result = await dio
        .get('meetings/past', queryParameters: {'page': page, 'limit': limit});
    return (result.data['meetings'] as List)
        .map((e) => MeetEntity.fromJson(e))
        .toList();
  }

  Future<MeetEntity> createMeet(
      {required String title,
      required String description,
      required TimeOfDay time,
      required LatLng location}) async {
    var result = await dio.post('/meetings/', data: {
      'title': title,
      'description': description,
      'date': DateTime.now()
          .copyWith(hour: time.hour, minute: time.minute)
          .toUtc()
          .toIso8601String(),
      'latitude': location.latitude,
      'longitude': location.longitude
    });
    return MeetEntity.fromJson(result.data);
  }

  Future<MeetEntity> getMeet(String meetId) async {
    var result = await dio.get('/meetings/$meetId');
    return MeetEntity.fromJson(result.data);
  }

  Future joinMeet(String meetId) async {
    var result = await dio.post('/meetings/$meetId/join');
    return;
  }

  Future kickUser(String meetId, String userIdToKickId) async {
    var result = await dio
        .post('/meetings/$meetId/kick', data: {'userIdToKick': userIdToKickId});
    return;
  }

  Future transferAdmin(String meetId, String newAdminId) async {
    var result = await dio.post('/meetings/$meetId/transfer-admin',
        data: {'newAdminId': newAdminId});
    return;
  }

  Future leaveMeet(String meetId) async {
    var result = await dio.post('/meetings/$meetId/leave');
    return;
  }

  Future cancelMeet(String meetId) async {
    var result = await dio.post('/meetings/$meetId/cancel');
    return;
  }

  Future<List<MeetEntity>> getMeets(
      double latitude, double longitude, double radius) async {
    var result = await dio.get('/meetings', queryParameters: {
      'latitude': latitude,
      'longitude': longitude,
      'radius': radius
    });
    return (result.data as List).map((e) => MeetEntity.fromJson(e)).toList();
  }

  Future<List<MeetEntity>> getCurrentMeets() async {
    var result = await dio.get('/meetings/current');
    return (result.data as List).map((e) => MeetEntity.fromJson(e)).toList();
  }
}
