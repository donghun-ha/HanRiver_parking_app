import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:RiverPark_Mate/vm/location_handler.dart';

class Routes extends StatelessWidget {
  Routes({super.key});
  final LocationHandler controller = Get.find();
  @override
  Widget build(BuildContext context) {
    final index = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.parkingInfo[index].pname),
        leading: IconButton(
            onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back)),
      ),
      body: _googleMap(context, index),
    );
  }

  Widget _googleMap(context, index) {
    return GoogleMap(
      mapType: MapType.terrain,
      initialCameraPosition: CameraPosition(
        zoom: 13,
        target:
            LatLng(controller.currentlat.value, controller.currentlng.value),
      ),
      onMapCreated: (GoogleMapController mapController) {
        controller.routesController.value = mapController;
      },
      markers: {
        Marker(
            markerId: MarkerId(controller.parkingInfo[index].pname),
            position: LatLng(controller.parkingInfo[index].lat,
                controller.parkingInfo[index].lng))
      },
      polylines: controller.lines.toSet(),
      myLocationButtonEnabled: true,
      myLocationEnabled: true,
      zoomControlsEnabled: true,
      zoomGesturesEnabled: true,
      rotateGesturesEnabled: true,
      scrollGesturesEnabled: true,
    );
  }
}
