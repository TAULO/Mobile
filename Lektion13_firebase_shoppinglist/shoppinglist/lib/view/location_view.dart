import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shoppinglist/model/LocationState.dart';
import 'package:shoppinglist/service/LocationService.dart';

class LocationView extends StatefulWidget {
  LocationView({Key? key}) : super(key: key);

  @override
  State<LocationView> createState() => _LocationViewState();
}

class _LocationViewState extends State<LocationView> {
  LocationState state = LocationState();
  GoogleMapController? mapController;

  static const GeoPoint foetex = GeoPoint(56.150990, 10.199460);
  static const GeoPoint rema = GeoPoint(56.153620, 10.202610);

  static const zoom = 14.0;

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
  int markerID = 0;

  CameraPosition homePosition(double lat, double long) {
    return CameraPosition(target: LatLng(lat, long), zoom: zoom);
  }

  void retryLoad() {
    setState(() {
      state.getGeo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Google Maps"),
      ),
      body: FutureBuilder<GeoPoint>(
        future: state.getGeo,
        builder: (BuildContext context, AsyncSnapshot<GeoPoint> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            children = <Widget>[
              SizedBox(
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
                      snapshot.data!.latitude, snapshot.data!.longitude),
                  onLongPress: (latLong) {
                    CameraUpdate newPos = CameraUpdate.newCameraPosition(
                        homePosition(
                            snapshot.data!.latitude, snapshot.data!.longitude));
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
              ),
            ];
          } else if (snapshot.hasError) {
            children = [
              IconButton(
                onPressed: () => print("Reload"),
                icon: const Icon(
                  Icons.refresh_rounded,
                  size: 40,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 17),
                child: Text(
                  "Something went wrong!",
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ];
          } else {
            children = const [
              SizedBox(
                width: 60,
                height: 80,
                child: CircularProgressIndicator(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 17),
                child: Text(
                  "Loading Google Maps...",
                  style: TextStyle(fontSize: 17),
                ),
              ),
            ];
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ),
          );
        },
      ),
    );
  }
}
