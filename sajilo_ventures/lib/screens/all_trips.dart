import 'package:charts_flutter/flutter.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:sajilo_ventures/helper/all_trips_helper.dart';
import 'package:sajilo_ventures/tripswidgets/all_trip_filter.dart';
import 'package:sajilo_ventures/tripswidgets/trip_item_widget.dart';

class AllTrips extends StatefulWidget {
  const AllTrips({Key? key}) : super(key: key);

  @override
  State<AllTrips> createState() => _AllTripsState();
}

class _AllTripsState extends State<AllTrips> {
  @override
  Widget build(BuildContext context) {
    final _loadedItem = Provider.of<AllTripsHelper>(context).items;
    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 0.0,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 12,
            )),
        backgroundColor: Colors.white,
        title: const Text('All Trips'),
        centerTitle: true,
        titleTextStyle: Theme.of(context).textTheme.headline1,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AllTripFilter('7 days'),
                AllTripFilter('15 days'),
                AllTripFilter('30 days'),
              ],
            ),
          ),

          // TripItemWidget(),
          Expanded(
            child: ListView.builder(
                itemCount: _loadedItem.length,
                itemBuilder: (_, index) {
                  return Column(
                    children: [
                      TripItemWidget(
                          _loadedItem[index].tripId,
                          _loadedItem[index].tripdate,
                          _loadedItem[index].pickupLocation,
                          _loadedItem[index].destination,
                          _loadedItem[index].tripCost,
                          _loadedItem[index].tripRating,
                          _loadedItem[index].imageUrl),
                      const Divider(
                        height: 15,
                      ),
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }
}
