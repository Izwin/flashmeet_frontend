import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class MainEvent{}

class GetUserLocationEvent extends MainEvent{

}

class GetMapMeetsEvent extends MainEvent{
  final LatLng center;
  final double radius;

  GetMapMeetsEvent({required this.center, required this.radius});
}

class GetNearbyMeetsEvent extends MainEvent{

}

class GetCurrentMeetsEvent extends MainEvent {

}