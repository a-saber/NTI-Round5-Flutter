import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nti5/features/trip/cubit/trip_cubit/trip_state.dart';

class TripCubit extends Cubit<TripState>{
  TripCubit() : super(TripInitial());
  static TripCubit get(context) => BlocProvider.of(context);

  LatLng? fromLocation;
  LatLng? toLocation;
  Set<Marker> markers = {};
  Set<Polyline> polylines = {};

  onMapTapped(LatLng latLng){
    if(fromLocation == null){
      changeFromLocation(latLng);
    }
    else{
      changeToLocation(latLng);
    }
    emit(LocationChanged());

  }

  changeFromLocation(LatLng newLocation){
    fromLocation = newLocation;
    markers.add(Marker(
      markerId: MarkerId('from'),
      position: fromLocation!
    ));
  }
  changeToLocation(LatLng newLocation){
    toLocation = newLocation;
    markers.add(Marker(
      markerId: MarkerId('to'),
      position: toLocation!
    ));
    polylines = {
      Polyline(
          polylineId: PolylineId('1'),
          points: [fromLocation!, toLocation!]
      )
    };
  }
}