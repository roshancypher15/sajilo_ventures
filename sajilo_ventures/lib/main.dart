import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sajilo_ventures/helper/all_trips_helper.dart';
import 'package:sajilo_ventures/screens/all_trips.dart';
import 'package:sajilo_ventures/screens/trip_summary.dart';
import './screens/dashboard.dart';
import './helper/analytics_item.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  MaterialColor buildMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AnalyticsHelper()),
        ChangeNotifierProvider.value(value: AllTripsHelper())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          textTheme: GoogleFonts.openSansTextTheme(Theme.of(context).textTheme)
              .copyWith(
                  headline1: GoogleFonts.openSans(
                      textStyle: Theme.of(context).textTheme.headline1,
                      fontSize: 21,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                  bodyText1: GoogleFonts.robotoCondensed(
                      textStyle: Theme.of(context).textTheme.bodyText1,
                      fontWeight: FontWeight.w700,
                      fontSize: 15)),
          colorScheme: ColorScheme.fromSwatch(
              primarySwatch:
                  buildMaterialColor(const Color.fromRGBO(199, 33, 38, 1))),
        ),
        home: const AllTrips(),
        routes: {
          TripSummary.routeName: (ctx) => const TripSummary(),
        },
      ),
    );
  }
}
