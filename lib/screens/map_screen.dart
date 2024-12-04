import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatelessWidget {
  final String memberName;
  final LatLng currentLocation;
  final List<LatLng> route;

  MapScreen({
    required this.memberName,
    required this.currentLocation,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$memberName - Map View'),
        backgroundColor: Colors.purple,
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: currentLocation,
          zoom: 14,
        ),
        markers: _buildMarkers(),
        polylines: _buildPolylines(),
      ),
    );
  }

  Set<Marker> _buildMarkers() {
    Set<Marker> markers = {
      Marker(
        markerId: MarkerId('currentLocation'),
        position: currentLocation,
        infoWindow: InfoWindow(title: 'Current Location'),
      ),
    };

    for (int i = 0; i < route.length; i++) {
      markers.add(
        Marker(
          markerId: MarkerId('route_$i'),
          position: route[i],
          infoWindow: InfoWindow(title: 'Visited Location ${i + 1}'),
        ),
      );
    }

    return markers;
  }

  Set<Polyline> _buildPolylines() {
    return {
      Polyline(
        polylineId: PolylineId('routePolyline'),
        points: route,
        color: Colors.blue,
        width: 4,
      ),
    };
  }
}
