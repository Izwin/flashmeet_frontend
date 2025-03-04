import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class LocationPickerEvent{

}
class GetUserLocationEvent extends LocationPickerEvent{}
class SetLocationEvent extends LocationPickerEvent{
  final LatLng location;

  SetLocationEvent({required this.location});
}