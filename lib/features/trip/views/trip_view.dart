import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../cubit/trip_cubit/trip_cubit.dart';
import '../cubit/trip_cubit/trip_state.dart';

class TripView extends StatelessWidget {
  const TripView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> TripCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Trip'),
        ),
        body: BlocBuilder<TripCubit, TripState>(
          builder: (context, state) {
            return GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(31.0, 31.5),
                zoom: 12
              ),
              markers: TripCubit.get(context).markers,
              polylines: TripCubit.get(context).polylines,
              onTap: TripCubit.get(context).onMapTapped
            );
          }
        ),
      ),
    );
  }
}
