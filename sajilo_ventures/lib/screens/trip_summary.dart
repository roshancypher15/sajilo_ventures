import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sajilo_ventures/helper/all_trips_helper.dart';
import 'package:sajilo_ventures/marker_icons.dart';
import 'package:sajilo_ventures/tripswidgets/row_item.dart';

import '../maps_icon_icons.dart';

class TripSummary extends StatefulWidget {
  static const routeName = 'tripSummary';
  const TripSummary({Key? key}) : super(key: key);

  @override
  State<TripSummary> createState() => _TripSummaryState();
}

class _TripSummaryState extends State<TripSummary> {
  @override
  Widget build(BuildContext context) {
    final _data = ModalRoute.of(context)!.settings.arguments;
    final _loaded = Provider.of<AllTripsHelper>(context).trip(_data.toString());
    double rating = _loaded.tripRating;

    return Scaffold(
        appBar: AppBar(
          bottomOpacity: 0.0,
          elevation: 0.0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
                rating = 0;
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 12,
              )),
          backgroundColor: Colors.white,
          title: const Text('Trip Details'),
          centerTitle: true,
          titleTextStyle: Theme.of(context).textTheme.headline1,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          margin: const EdgeInsets.only(left: 10, right: 10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text('Trip Details',
                  style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'RobotoCondensed',
                      fontWeight: FontWeight.w700,
                      color: Colors.black)),
            ),
            const SizedBox(
              height: 20,
            ),
            RowItem('Trip ID', _loaded.tripId),
            const SizedBox(
              height: 20,
            ),
            RowItem('Date & Time', _loaded.tripdate),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Rating',
                  style: TextStyle(fontSize: 15),
                ),
                RatingBar.builder(
                    itemPadding: const EdgeInsets.only(left: 6),
                    itemSize: 30,
                    ignoreGestures: true,
                    allowHalfRating: true,
                    glowColor: Colors.transparent,
                    initialRating: rating,
                    minRating: rating,
                    maxRating: rating,
                    itemBuilder: (ctx, _) => const Icon(
                          Icons.star,
                          color: Colors.amberAccent,
                        ),
                    onRatingUpdate: (rating) {}),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Column(
                  children: const [
                    Icon(
                      MapsIcon.pin,
                      color: Colors.pink,
                    ),
                    Icon(
                      Icons.more_vert_outlined,
                      size: 18,
                      color: Colors.pink,
                    ),
                    Icon(
                      Marker.location_2,
                      color: Colors.pink,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _loaded.pickupLocation,
                        style: GoogleFonts.openSans(
                            textStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                          fontSize: 14,
                        )),
                      ),
                      const SizedBox(height: 20),
                      Text(_loaded.destination,
                          style: GoogleFonts.openSans(
                              textStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5,
                            fontSize: 14,
                          ))),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.pink,
                    child: CircleAvatar(
                      radius: 33,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            NetworkImage(_loaded.imageUrl.toString()),
                      ),
                    ),
                  ),
                ),
                Text(
                  _loaded.name,
                  style: const TextStyle(
                    fontFamily: 'RobotoCondensed',
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const Text(
                      'Total Distance',
                      style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 156, 155, 155)),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text('${_loaded.distance.toString()} KM',
                        style: const TextStyle(
                          fontFamily: 'RobotoCondensed',
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ))
                  ],
                ),
                Column(
                  children: [
                    const Text(
                      'Fair',
                      style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 156, 155, 155)),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text('Rs.${_loaded.tripCost.toString()}',
                        style: const TextStyle(
                          fontFamily: 'RobotoCondensed',
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ))
                  ],
                ),
                Column(
                  children: [
                    const Text(
                      'Travel Time',
                      style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 156, 155, 155)),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text('${_loaded.tripTime.toString()} Min',
                        style: const TextStyle(
                          fontFamily: 'RobotoCondensed',
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ))
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 10),
              child: Container(
                height: 180,
                width: 350,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Color.fromARGB(255, 243, 239, 239)),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 25, right: 10),
                      child: Text('Receipt',
                          style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'RobotoCondensed',
                              fontWeight: FontWeight.w700,
                              color: Colors.black)),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Text(
                            'Base Fair  ',
                            style: TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 156, 155, 155)),
                          ),
                          Text('Rs. ${(_loaded.tripCost - 10).toString()}',
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black)),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const <Widget>[
                          Text(
                            'Surge  ',
                            style: TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 156, 155, 155)),
                          ),
                          Text('Rs. 10',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black)),
                        ],
                      ),
                    ),
                    const Text(
                      '---------------------------------------------',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 219, 217, 217)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Text(
                            'Total  ',
                            style: TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 156, 155, 155)),
                          ),
                          Text('Rs. ${(_loaded.tripCost).toString()}',
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            Container(
              width: 400,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Done',
                  style: TextStyle(
                      fontFamily: 'RobotoCondensed',
                      fontSize: 20,
                      color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
              ),
            ),
          ]),
        ));
  }
}
