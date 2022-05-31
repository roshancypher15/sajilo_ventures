import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sajilo_ventures/helper/location_service.dart';

import 'package:sajilo_ventures/verified_icons.dart';
import '../helper/location_service.dart';
import 'package:custom_info_window/custom_info_window.dart';

import 'dart:async';
import 'dart:ui' as ui;

class RedirectedPage extends StatefulWidget {
  static const routeName = ' redirect';
  const RedirectedPage({Key? key}) : super(key: key);

  @override
  State<RedirectedPage> createState() => _RedirectedPageState();
}

class _RedirectedPageState extends State<RedirectedPage> {
  final List<LatLng> _listLatLng = const [
    LatLng(27.6747752, 85.3423544),
    LatLng(27.6915247, 85.3398613),
    LatLng(27.6867652, 85.3233535),
    LatLng(27.6846742, 85.322744),
    LatLng(27.6707552, 85.3313544),
    LatLng(27.6772904, 85.3178902),
    LatLng(27.6879191, 85.3496212),
    LatLng(27.6911188, 85.3360133),
  ];
  late BitmapDescriptor originIcon;
  late BitmapDescriptor destinationIcon;

  late BitmapDescriptor bikeIcon;
  late BitmapDescriptor carIcon;
  final CustomInfoWindowController _controller = CustomInfoWindowController();
  final CameraPosition _initialCameraPosition = const CameraPosition(
    target: LatLng(27.6947033, 85.3310636),
    zoom: 13.4746,
  );
  int i = 0;
  final Set<Polyline> _polylines = <Polyline>{};
  final Set<Marker> _markers = <Marker>{};
  int _polyLineIdCounter = 1;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0)).then((_) {
      _submit();
      Timer(const Duration(seconds: 2), () => Navigator.of(context).pop());
    });
    _initmarker();

    _maps();

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  void _initmarker() async {
    final Uint8List markerIconOrigin =
        await getBytesFromAsset('assets/pointer.png', 60);
    originIcon = BitmapDescriptor.fromBytes(markerIconOrigin);
    final Uint8List markerIconDesti =
        await getBytesFromAsset('assets/joystick.png', 100);
    destinationIcon = BitmapDescriptor.fromBytes(markerIconDesti);
    final Uint8List initialBikeIcon =
        await getBytesFromAsset('assets/bike.png', 60);
    bikeIcon = BitmapDescriptor.fromBytes(initialBikeIcon);
    final Uint8List initialCarIcon =
        await getBytesFromAsset('assets/car_side.png', 60);
    carIcon = BitmapDescriptor.fromBytes(initialCarIcon);
  }

  void _setmarker(
      LatLng points, String id, String address, BitmapDescriptor _icon) {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId(id),
        icon: _icon,
        position: points,
        onTap: () {
          _controller.addInfoWindow!(
            Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              address,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ],
            ),
            points,
          );
        },
      ));
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
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _initialCameraPosition,
            zoomControlsEnabled: true,
            onTap: (position) {
              _controller.hideInfoWindow!();
            },
            onCameraMove: (position) {
              _controller.onCameraMove!();
            },
            polylines: _polylines,
            onMapCreated: (GoogleMapController controller) async {
              _controller.googleMapController = controller;
            },
            markers: _markers,
          ),
          CustomInfoWindow(
            controller: _controller,
            height: 50,
            width: 220,
            offset: 40,
          ),
        ],
      ),
    );
  }

  Future<void> _goToPlace(
      double startLat,
      double startLng,
      double endLat,
      double endLng,
      String startAddress,
      String endAddress,
      Map<String, dynamic> boundsNe,
      Map<String, dynamic> boundsSw) async {
    _controller.googleMapController!.animateCamera(
        CameraUpdate.newCameraPosition(
            CameraPosition(target: LatLng(endLat, endLng), zoom: 17)));
    _controller.googleMapController!.animateCamera(CameraUpdate.newLatLngBounds(
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
        'origin',
        startAddress,
        originIcon);

    _setmarker(
        LatLng(
          endLat,
          endLng,
        ),
        'destination',
        endAddress,
        destinationIcon);
    for (i = 1; i <= _listLatLng.length; i++) {
      if (i % 2 == 0) {
        _setmarker(_listLatLng[i], 'bike$i', 'Bike Rider', bikeIcon);
      } else {
        _setmarker(_listLatLng[i], 'Car$i', 'Car Rider', carIcon);
      }
    }
  }

  Future<void> _maps() async {
    var directions = await LocationService()
        .getDirections('Patan Durbar Square', 'Tribhwan International Airport');
    _goToPlace(
        directions['start_location']['lat'],
        directions['start_location']['lng'],
        directions['end_location']['lat'],
        directions['end_location']['lng'],
        directions['start_address'],
        directions['end_address'],
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

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }
}
