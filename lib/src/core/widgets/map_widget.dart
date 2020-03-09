import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TheMap extends StatefulWidget {
  ///key is required, otherwise map crashes on hot reload
  TheMap({@required Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<TheMap> {
  GoogleMapController _mapController;

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //also this avoids it crashing/breaking when the keyboard is up
        resizeToAvoidBottomInset: false,
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: const LatLng(30.0925973, 31.3219982),
            zoom: 11.0,
          ),
        ));
  }


}
