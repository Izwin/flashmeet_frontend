import 'package:flash_meet_frontend/features/meet/presentation/bloc/meet_bloc.dart';
import 'package:flash_meet_frontend/features/meet/presentation/bloc/meet_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MeetLocationSection extends StatelessWidget {
  const MeetLocationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MeetBloc, MeetState>(
      builder: (context, state) {
        if (state.status == MeetStatus.loading ||
            state.meetEntity?.longitude == null ||
            state.meetEntity?.latitude == null) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Location',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  CupertinoIcons.location_solid,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 300,
              width: double.maxFinite,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(12)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                      target: LatLng(
                        state.meetEntity!.latitude!,
                        state.meetEntity!.longitude!,
                      ),
                      zoom: 15),
                  markers: {
                    Marker(
                        markerId: MarkerId('location'),
                        position: LatLng(
                          state.meetEntity!.latitude!,
                          state.meetEntity!.longitude!,
                        ))
                  },
                  myLocationEnabled: false,
                  myLocationButtonEnabled: false,
                  zoomGesturesEnabled: false,
                  zoomControlsEnabled: false,
                  scrollGesturesEnabled: false,
                  rotateGesturesEnabled: false,
                  tiltGesturesEnabled: false,
                  compassEnabled: false,
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
