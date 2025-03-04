import 'package:flash_meet_frontend/core/router/app_router.dart';
import 'package:flash_meet_frontend/core/utils/google_map_utils.dart';
import 'package:flash_meet_frontend/features/create_meet/presentation/page/create_meet_page.dart';
import 'package:flash_meet_frontend/features/main/presentation/bloc/main_bloc.dart';
import 'package:flash_meet_frontend/features/main/presentation/bloc/main_event.dart';
import 'package:flash_meet_frontend/features/main/presentation/bloc/main_state.dart';
import 'package:flash_meet_frontend/features/main/presentation/widgets/main_bottom_sheet.dart';
import 'package:flash_meet_frontend/features/meet/domain/entity/meet_entity.dart';
import 'package:flash_meet_frontend/features/meet/presentation/page/meet_page.dart';
import 'package:flash_meet_frontend/features/profile/presentation/page/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  static const String route = '/main';

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static const double baseRadius = 120000;
  GoogleMapController? mapController;
  Set<Marker> mapMarkers = {};

  @override
  void initState() {
    super.initState();
    context.read<MainBloc>().add(GetUserLocationEvent());
    context.read<MainBloc>().add(GetCurrentMeetsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainBloc, MainState>(
      listener: (context, state) {
        if (state.mapStatus == MainStatus.successfullyGotUserLocation &&
            state.userLocation != null) {
          mapController?.animateCamera(
              CameraUpdate.newLatLngZoom(state.userLocation!, 15));
          context.read<MainBloc>().add(GetNearbyMeetsEvent());
        }
        if (state.mapStatus == MainStatus.success &&
            (state.mapMeets?.isNotEmpty ?? false)) {
          updateMarkers(state.mapMeets!);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(target: LatLng(40, 40)),
                onMapCreated: (controller) {
                  mapController = controller;
                },
                myLocationEnabled: true,
                markers: mapMarkers,
                onCameraIdle: () {
                  if (mapController == null) return;

                  mapController!.getVisibleRegion().then((bounds) async {
                    final center = LatLng(
                        (bounds.northeast.latitude +
                                bounds.southwest.latitude) /
                            2,
                        (bounds.northeast.longitude +
                                bounds.southwest.longitude) /
                            2);
                    final radius =
                        _calculateRadius(await mapController!.getZoomLevel());

                    context
                        .read<MainBloc>()
                        .add(GetMapMeetsEvent(center: center, radius: radius));
                  });
                },
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          context.push(CreateMeetPage.route);
                        },
                        icon: Icon(Icons.add),
                        iconSize: 30,
                        style: IconButton.styleFrom(
                          elevation: 3,
                          shadowColor: Colors.grey.withOpacity(0.8),
                          foregroundColor: Theme.of(context).colorScheme.onSurface,
                          backgroundColor: Theme.of(context).colorScheme.secondary
                        ),
                      ),
                      SizedBox(width: 10,),
                      IconButton(onPressed: (){
                        context.push(ProfilePage.route);
                      }, icon: Icon(Icons.person),
                        iconSize: 30,
                        style: IconButton.styleFrom(
                          elevation: 3,
                            shadowColor: Colors.grey.withOpacity(0.8),

                            backgroundColor: Theme.of(context).colorScheme.surface,
                        foregroundColor: Theme.of(context).colorScheme.onSurface
                      ),)
                    ],
                  ),
                ),
              ),
              MainBottomSheet()
            ],
          ),
        );
      },
    );
  }

  double _calculateRadius(double zoom) {
    return baseRadius / (zoom / 5);
  }

  Future updateMarkers(List<MeetEntity> meets) async {
    Set<Marker> newMarkers = {};

    for (var value in meets) {
      final BitmapDescriptor icon = await GoogleMapUtils.getMarkerIcon(value.admin.avatar);
      newMarkers.add(
        Marker(
          markerId: MarkerId(value.id),
          icon: icon,
          position: LatLng(value.latitude!, value.longitude!),
          onTap: (){
            context.push(MeetPage.route(value.id));
          }
        ),
      );
      setState(() {
        mapMarkers = newMarkers;
      });
    }
  }

  
}
