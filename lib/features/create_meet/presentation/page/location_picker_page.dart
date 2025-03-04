import 'package:flash_meet_frontend/core/get_it/get_it.dart';
import 'package:flash_meet_frontend/core/router/app_router.dart';
import 'package:flash_meet_frontend/core/ui/default_button.dart';
import 'package:flash_meet_frontend/features/create_meet/presentation/bloc/location_picker_bloc.dart';
import 'package:flash_meet_frontend/features/create_meet/presentation/bloc/location_picker_event.dart';
import 'package:flash_meet_frontend/features/create_meet/presentation/bloc/location_picker_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationPickerPage extends StatefulWidget {
  static const String route = '/location_picker';

  const LocationPickerPage({super.key});

  @override
  State<LocationPickerPage> createState() => _LocationPickerPageState();
}

class _LocationPickerPageState extends State<LocationPickerPage> {
  GoogleMapController? mapController;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<LocationPickerBloc>()..add(GetUserLocationEvent()),
      child: BlocConsumer<LocationPickerBloc, LocationPickerState>(
        listener: (context, state) {
          if (state.status == LocationPickerStatus.success &&
              state.location != null) {
            mapController?.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(target: state.location!, zoom: 10)));
          }
        },
        builder: (context, state) {
          if (state.status == LocationPickerStatus.loading) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            );
          }
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Select location',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              centerTitle: false,
            ),
            body: Stack(
              children: [
                GoogleMap(
                    initialCameraPosition: CameraPosition(
                        target: state.location ?? LatLng(40.730610, -73.935242),
                        zoom: 10),
                myLocationEnabled: true,
                  onCameraMove: (camera){
                      context.read<LocationPickerBloc>().add(SetLocationEvent(location: camera.target));
                  },
                  onMapCreated: (controller){
                      mapController = controller;
                  },
                ),
                Center(
                  child: Icon(
                    Icons.location_pin,
                    color: Theme.of(context).colorScheme.error,
                    size: 40,
                  ),
                ),
                Positioned(bottom: 20,left: 20,right: 20,child: DefaultButton(
                  text: 'Select',
                  onPressed:state.location!=null ? (){
                    context.pop(state.location);
                  } : null,
                ))
              ],
            ),
          );
        },
      ),
    );
  }
}
