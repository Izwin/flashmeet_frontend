import 'package:equatable/equatable.dart';
import 'package:flash_meet_frontend/features/meet/domain/entity/meet_entity.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum MainStatus {
  initial,
  loading,
  success,
  successfullyGotUserLocation,
  error
}

class MainState extends Equatable {
  final MainStatus mapStatus;

  final List<MeetEntity>? mapMeets;
  final String? mapErrorMessage;

  final LatLng? userLocation;

  final MainStatus nearbyStatus;
  final List<MeetEntity>? nearbyMeets;
  final String? nearbyErrorMessage;

  final MainStatus currentMeetsStatus;
  final List<MeetEntity>? currentMeets;
  final String? currentMeetsErrorMessage;

  MainState._(
      {required this.mapStatus,
      this.mapMeets,
      this.mapErrorMessage,
      this.userLocation,
      required this.nearbyStatus,
      this.nearbyMeets,
      this.nearbyErrorMessage,
      required this.currentMeetsStatus,
      this.currentMeets,
      this.currentMeetsErrorMessage});

  factory MainState.initial() => MainState._(
      mapStatus: MainStatus.initial,
      nearbyStatus: MainStatus.initial,
      currentMeetsStatus: MainStatus.initial);

  MainState copyWith(
      {MainStatus? mapStatus,
      List<MeetEntity>? mapMeets,
      String? mapErrorMessage,
      LatLng? userLocation,
      MainStatus? nearbyStatus,
      List<MeetEntity>? nearbyMeets,
      String? nearbyErrorMessage,
      MainStatus? currentMeetsStatus,
      List<MeetEntity>? currentMeets,
      String? currentMeetsErrorMessage}) {
    return MainState._(
        mapStatus: mapStatus ?? this.mapStatus,
        mapMeets: mapMeets ?? this.mapMeets,
        mapErrorMessage: mapErrorMessage ?? this.mapErrorMessage,
        userLocation: userLocation ?? this.userLocation,
        nearbyStatus: nearbyStatus ?? this.nearbyStatus,
        nearbyMeets: nearbyMeets ?? this.nearbyMeets,
        nearbyErrorMessage: nearbyErrorMessage ?? this.nearbyErrorMessage,
        currentMeetsStatus: currentMeetsStatus ?? this.currentMeetsStatus,
        currentMeets: currentMeets ?? this.currentMeets,
        currentMeetsErrorMessage:
            currentMeetsErrorMessage ?? this.currentMeetsErrorMessage);
  }

  @override
  List<Object?> get props => [
        mapStatus,
        mapMeets,
        mapErrorMessage,
        userLocation,
        nearbyStatus,
        nearbyMeets,
        nearbyErrorMessage,
        currentMeetsStatus,
        currentMeets,
        currentMeetsErrorMessage
      ];
}
