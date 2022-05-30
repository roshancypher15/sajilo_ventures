import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sajilo_ventures/helper/location_service.dart';

import 'package:sajilo_ventures/verified_icons.dart';
import '../helper/location_service.dart';

import 'dart:async';

class RedirectedPage extends StatefulWidget {
  static const routeName = ' redirect';
  const RedirectedPage({Key? key}) : super(key: key);

  @override
  State<RedirectedPage> createState() => _RedirectedPageState();
}

class _RedirectedPageState extends State<RedirectedPage> {
  final Completer<GoogleMapController> _controller = Completer();
  final CameraPosition _initialCameraPosition = const CameraPosition(
    target: LatLng(27.6947033, 85.3310636),
    zoom: 13.4746,
  );
  final Set<Polyline> _polylines = <Polyline>{};
  final Set<Marker> _markers = <Marker>{};
  int _polyLineIdCounter = 1;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0)).then((_) {
      _submit();
      Timer(const Duration(seconds: 2), () => Navigator.of(context).pop());
    });
    _maps();

    // TODO: implement initState
    super.initState();
  }

  void _setmarker(LatLng points, String Id, double color) {
    setState(() {
      _markers.add(Marker(
          markerId: MarkerId(Id),
          infoWindow: InfoWindow(title: Id),
          icon: BitmapDescriptor.defaultMarkerWithHue(color),
          position: points));
    });
  }

  void _setPolyline(List<PointLatLng> points) {
    final String polylineIdVal = 'polyline_$_polyLineIdCounter';
    _polyLineIdCounter++;
    _polylines.add(
      Polyline(
        polylineId: PolylineId(polylineIdVal),
        width: 4,
        color: Colors.blue,
        points: points
            .map((point) => LatLng(point.latitude, point.longitude))
            .toList(),
      ),
    );
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
        polylines: _polylines,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: _markers,
      ),
    );
  }

  Future<void> _goToPlace(
      double startLat,
      double startLng,
      double endLat,
      double endLng,
      Map<String, dynamic> boundsNe,
      Map<String, dynamic> boundsSw) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(endLat, endLng), zoom: 17)));
    controller.animateCamera(CameraUpdate.newLatLngBounds(
        LatLngBounds(
          northeast: LatLng(boundsNe['lat'], boundsNe['lng']),
          southwest: LatLng(boundsSw['lat'], boundsSw['lng']),
        ),
        25));
    _setmarker(
        LatLng(
          startLat,
          startLng,
        ),
        'oirgin',
        BitmapDescriptor.hueBlue);

    _setmarker(
        LatLng(
          endLat,
          endLng,
        ),
        'destination',
        BitmapDescriptor.hueRed);
  }

  Future<void> _maps() async {
    var directions =
        await LocationService().getDirections('koteshowr', 'baneshowr');
    _goToPlace(
        directions['start_location']['lat'],
        directions['start_location']['lng'],
        directions['end_location']['lat'],
        directions['end_location']['lng'],
        directions['bounds_ne'],
        directions['bounds_sw']);

    _setPolyline(directions['polyline_decoded']);
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
