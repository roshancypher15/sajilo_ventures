import 'package:flutter/material.dart';
import 'package:sajilo_ventures/blooddrop_icons.dart';
import 'package:sajilo_ventures/maps_icon_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sajilo_ventures/marker_icons.dart';
import 'package:sajilo_ventures/verified_icons.dart';
import 'package:sajilo_ventures/widgets/report_reasons.dart';

class ReportRider extends StatefulWidget {
  const ReportRider({Key? key}) : super(key: key);

  @override
  State<ReportRider> createState() => _ReportRiderState();
}

class _ReportRiderState extends State<ReportRider> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 0.0,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 12,
            )),
        backgroundColor: Colors.white,
        title: const Text('Report this Rider'),
        centerTitle: true,
        titleTextStyle: Theme.of(context).textTheme.headline1,
      ),
      body: Container(
        width: 380,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 40),
              child: CircleAvatar(
                radius: 35,
                backgroundColor: Colors.pink,
                child: CircleAvatar(
                  radius: 33,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                      'https://cdn.pixabay.com/photo/2021/01/29/08/08/dog-5960092_960_720.jpg',
                    ),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                'Prabal Rai',
                style: TextStyle(
                  fontFamily: 'RobotoCondensed',
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 5),
              child: Text(
                '+977-9844000000',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: const [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      Text(
                        '4.5',
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                  Row(
                    children: const [
                      Text(
                        '1234  ',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Trips',
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                  Row(
                    children: const [
                      Icon(
                        Blooddrop.blood_drop,
                        color: Colors.red,
                        size: 20,
                      ),
                      Text(
                        'O+ve',
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                  Row(
                    children: const [
                      Icon(
                        Verified.icons8_verified_account_100,
                        color: Colors.green,
                        size: 20,
                      ),
                      Text(
                        'Professional',
                        style: TextStyle(color: Colors.green, fontSize: 16),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: const <Widget>[
                  SizedBox(
                    width: 25,
                  ),
                  Text(
                    'Bike Details',
                    style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'RobotoCondensed',
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text('Pulsar 220',
                      style: TextStyle(
                          letterSpacing: 1,
                          fontSize: 16,
                          fontFamily: 'RobotoCondensed',
                          color: Colors.black)),
                  SizedBox(
                    width: 20,
                  ),
                  Divider(
                    height: 4,
                    thickness: 3,
                    color: Colors.red,
                  ),
                  Text('Ba Pr 02-022 Pa 2601',
                      style: TextStyle(
                          letterSpacing: 1.5,
                          fontSize: 16,
                          fontFamily: 'RobotoCondensed',
                          color: Colors.black))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 15),
              child: Column(
                children: [
                  Row(
                    children: const [
                      Text('Trip Details',
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'RobotoCondensed',
                              fontWeight: FontWeight.w600,
                              color: Colors.black)),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Column(
                        children: const [
                          Icon(
                            MapsIcon.pin,
                            color: Color.fromARGB(255, 206, 41, 96),
                            size: 30,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Icon(
                            Icons.more_vert_outlined,
                            size: 18,
                            color: Color.fromARGB(255, 206, 41, 96),
                          ),
                          Icon(
                            Marker.location_2,
                            color: Color.fromARGB(255, 206, 41, 96),
                            size: 30,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pulchowk',
                              style: GoogleFonts.openSans(
                                  textStyle: const TextStyle(
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.5,
                                fontSize: 15,
                              )),
                            ),
                            const SizedBox(height: 30),
                            Text('Learning Realm International School',
                                style: GoogleFonts.openSans(
                                    textStyle: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.5,
                                  fontSize: 15,
                                ))),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Divider(
              height: 15,
              thickness: 1,
              indent: 10,
              endIndent: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: const [
                      Text(
                        'Total Distance',
                        style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 156, 155, 155)),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text('3 KM',
                          style: TextStyle(
                            fontFamily: 'RobotoCondensed',
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ))
                    ],
                  ),
                  Column(
                    children: const [
                      Text(
                        'Fair',
                        style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 156, 155, 155)),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text('Rs.149',
                          style: TextStyle(
                            fontFamily: 'RobotoCondensed',
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ))
                    ],
                  ),
                  Column(
                    children: const [
                      Text(
                        'Travel Time',
                        style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 156, 155, 155)),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text('20 Min',
                          style: TextStyle(
                            fontFamily: 'RobotoCondensed',
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ))
                    ],
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 12, top: 20, bottom: 10),
              child: Text(
                'We are Sorry for the inconvinence! Could you explain what bothered you ?',
                style: TextStyle(
                    fontSize: 17,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Avenir Next'),
                textAlign: TextAlign.left,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Row(
                children: [
                  Container(
                    width: 160,
                    height: 4,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.pink),
                  ),
                ],
              ),
            ),
            const ReportReason(),
          ],
        ),
      ),
    );
  }
}
