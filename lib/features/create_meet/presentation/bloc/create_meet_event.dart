import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CreateMeetEvent {
  final String title;
  final String description;
  final TimeOfDay time;
  final LatLng location;

  CreateMeetEvent(
      {required this.title,
      required this.description,
      required this.time,
      required this.location});
}
