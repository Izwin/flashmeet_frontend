import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum LocationPickerStatus { initial, loading, success,locationUpdated, error }

class LocationPickerState extends Equatable {
  final LocationPickerStatus status;
  final String? errorMessage;
  final LatLng? location;

  LocationPickerState._(
      {required this.status, this.errorMessage, this.location});

  factory LocationPickerState.initial() =>
      LocationPickerState._(status: LocationPickerStatus.initial);

  LocationPickerState copyWith(
          {LocationPickerStatus? status,
          String? errorMessage,
          LatLng? location}) =>
      LocationPickerState._(
          status: status ?? this.status,
          errorMessage: errorMessage ?? this.errorMessage,
          location: location ?? this.location);

  @override
  List<Object?> get props => [status, errorMessage, location];
}
