import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapWidget extends StatefulWidget {
  GoogleMapWidget({Key? key, required this.snapshot}) : super(key: key);
  late AsyncSnapshot<GeoPoint> snapshot;
  @override
  State<GoogleMapWidget> createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {
  GoogleMapController? mapController;

  static const GeoPoint foetex = GeoPoint(56.150990, 10.199460);
  static const GeoPoint rema = GeoPoint(56.153620, 10.202610);

  static const zoom = 14.0;

  int markerID = 0;

  Set<Circle> circles = {
    Circle(
        circleId: const CircleId("???"),
        center: LatLng(
          foetex.latitude,
          foetex.longitude,
        ),
        strokeWidth: 3,
        strokeColor: Colors.blue.withOpacity(0.6),
        fillColor: Colors.blueAccent.withOpacity(0.4),
        radius: 200.0)
  };

  Set<Marker> markers = {
    Marker(
      markerId: const MarkerId("998"),
      position: LatLng(foetex.latitude, foetex.longitude),
      infoWindow: const InfoWindow(
        title: "Føtex",
        snippet: "Frederiks Alle 22-24",
      ),
      // icon: BitmapDescriptor.fromAssetImage(configuration, assetName),
    ),
    Marker(
        markerId: const MarkerId("999"),
        position: LatLng(rema.latitude, rema.longitude),
        infoWindow: const InfoWindow(
          title: "Rema",
          snippet: "Frederiksgade 82",
        )),
  };

  CameraPosition homePosition(double lat, double long) {
    return CameraPosition(target: LatLng(lat, long), zoom: zoom);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height -
          Scaffold.of(context).appBarMaxHeight!.toDouble(),
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        onMapCreated: ((controller) {
          setState(() {
            mapController = controller;
          });
        }),
        myLocationEnabled: true,
        initialCameraPosition: homePosition(
            widget.snapshot.data!.latitude, widget.snapshot.data!.longitude),
        onLongPress: (latLong) {
          CameraUpdate newPos = CameraUpdate.newCameraPosition(homePosition(
              widget.snapshot.data!.latitude, widget.snapshot.data!.longitude));
          mapController!.animateCamera(newPos);
        },
        onTap: (latLong) {
          setState(
            () {
              MarkerId id = MarkerId(markerID.toString());
              Marker newMarker = Marker(
                markerId: id,
                position: LatLng(latLong.latitude, latLong.longitude),
              );
              markers.add(newMarker);
              markerID++;
            },
          );
        },
        markers: markers,
        circles: circles,
      ),
    );
  }
}
