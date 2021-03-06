import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sajilo_ventures/helper/all_trips_helper.dart';
import 'package:sajilo_ventures/maps_icon_icons.dart';
import 'package:sajilo_ventures/marker_icons.dart';
import 'package:sajilo_ventures/screens/trip_summary.dart';

class TripItemWidget extends StatefulWidget {
  String tripId;
  String tripdate;
  String pickup;
  String destination;
  int rate;
  double tripRating;
  String imageUrl;
  TripItemWidget(this.tripId, this.tripdate, this.pickup, this.destination,
      this.rate, this.tripRating, this.imageUrl,
      {Key? key})
      : super(key: key);

  @override
  State<TripItemWidget> createState() => _TripItemState();
}

class _TripItemState extends State<TripItemWidget> {
  double rating = 1;
  @override
  Widget build(BuildContext context) {
    final _data = Provider.of<AllTripsHelper>(context);
    return InkWell(
      splashFactory: NoSplash.splashFactory,
      onTap: (() {
        Navigator.pushNamed(context, TripSummary.routeName,
            arguments: widget.tripId);
      }),
      child: Container(
        width: 380,
        height: 200,
        decoration:
            BoxDecoration(border: Border.all(color: Colors.transparent)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Trip ID  ',
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(widget.tripId,
                        style: const TextStyle(
                            fontFamily: 'RobotoCondensed',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.black)),
                  ],
                ),
                Text(widget.tripdate,
                    style: const TextStyle(
                        fontFamily: 'RobotoCondensed',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.black)),
              ],
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
                      Marker1.location_2,
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
                        widget.pickup,
                        style: GoogleFonts.openSans(
                            textStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                          fontSize: 14,
                        )),
                      ),
                      const SizedBox(height: 20),
                      Text(widget.destination,
                          style: GoogleFonts.inter(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
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
                        backgroundImage: NetworkImage(
                          widget.imageUrl,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: RatingBar.builder(
                      itemPadding: const EdgeInsets.only(left: 6),
                      itemSize: 30,
                      glow: false,
                      initialRating: _data.getRating(widget.tripId),
                      minRating: 1,
                      maxRating: 5,
                      itemBuilder: (ctx, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                      onRatingUpdate: (rating) async {
                        setState(() {
                          this.rating = rating;
                          _data.update(widget.tripId, rating);
                        });
                      }),
                ),
                const SizedBox(
                  width: 60,
                ),
                Text('Rs.${widget.rate.toString()}',
                    style: const TextStyle(
                        fontFamily: 'RobotoCondensed',
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.black)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
