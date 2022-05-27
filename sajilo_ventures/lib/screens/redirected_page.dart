import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:sajilo_ventures/verified_icons.dart';

import 'dart:async';

class RedirectedPage extends StatefulWidget {
  static const routeName = ' redirect';
  const RedirectedPage({Key? key}) : super(key: key);

  @override
  State<RedirectedPage> createState() => _RedirectedPageState();
}

class _RedirectedPageState extends State<RedirectedPage> {
  final CameraPosition _initialCameraPosition = const CameraPosition(
    target: LatLng(27.6947033, 85.3310636),
    zoom: 13.4746,
  );
  final Marker _origin = Marker(
      markerId: const MarkerId('Origin'),
      infoWindow: const InfoWindow(title: 'Origin'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      position: const LatLng(27.6947033, 85.3310636));

  final Marker _destination = Marker(
      markerId: const MarkerId('Destination'),
      infoWindow: const InfoWindow(title: 'Destination'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      position: const LatLng(27.6878074, 85.3484893));

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0)).then((_) {
      _submit();
     
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        bottomOpacity: 0.0,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {},
            icon: RawMaterialButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              elevation: 2.0,
              fillColor: Colors.white,
              child: const Icon(
                Icons.arrow_back_sharp,
                color: Colors.black,
                size: 25.0,
              ),
              shape: const CircleBorder(),
            )),
        backgroundColor: Colors.transparent,
      ),
      body: GoogleMap(
        initialCameraPosition: _initialCameraPosition,
        zoomControlsEnabled: true,
        
        markers: {_origin, _destination},
      ),
    );
  }

  Future<void> _submit() async {
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        context: context,
        builder: (builder) {
          return Container(
              margin: const EdgeInsets.all(15),
              height: 170,
              width: 250,
              color: Colors.transparent,
              child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      const Center(
                        child: Icon(
                          Verified.icons8_verified_account_100,
                          color: Color.fromARGB(255, 206, 41, 96),
                          size: 100,
                        ),
                      ),
                      Center(
                        child: Container(
                          width: 320,
                          child: const Text(
                            'Rider Report Successful',
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  )));
                
        });
        
  }
}
