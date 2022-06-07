import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:sajilo_ventures/screens/login_signup_alert.dart';

class UserOrRider extends StatefulWidget {
  const UserOrRider({Key? key}) : super(key: key);

  @override
  State<UserOrRider> createState() => _UserOrRiderState();
}

class _UserOrRiderState extends State<UserOrRider> {
  var _isRider = false;

  var _isUser = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 0.0,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {},
            icon: const FaIcon(
              FontAwesomeIcons.bars,
              color: Colors.black,
              size: 25,
            )),
        backgroundColor: Colors.white,
        title: const Text(''),
        centerTitle: true,
        titleTextStyle: Theme.of(context).textTheme.headline1,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(
            top: 120,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 140,
                    width: 179,
                    child: Card(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      elevation: 3.5,
                      shadowColor: Colors.white,
                      child: InkWell(
                        splashFactory: NoSplash.splashFactory,
                        onTap: (() {
                          setState(() {
                            _isRider = true;
                            _isUser = false;
                          });
                        }),
                        child: Column(
                          children: [
                            FittedBox(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      right: 5,
                                      left: 180,
                                      top: 5,
                                    ),
                                    child: Icon(
                                      _isRider
                                          ? Icons.check_circle
                                          : Icons.circle_outlined,
                                      size: 25,
                                      color: _isRider
                                          ? const Color.fromRGBO(220, 20, 60, 1)
                                          : Colors.grey,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 20, bottom: 10),
                              child: CircleAvatar(
                                  radius: 27,
                                  child: Icon(
                                    Icons.motorcycle,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  backgroundColor:
                                      const Color.fromARGB(255, 241, 198, 207)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 8, right: 20, top: 5),
                              child: Text('Rider',
                                  style: GoogleFonts.inter(
                                      textStyle: const TextStyle(
                                          fontFamily: 'RobotoCondensed',
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black))),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 140,
                    width: 179,
                    child: Card(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      elevation: 3.5,
                      shadowColor: Colors.white,
                      child: InkWell(
                        splashFactory: NoSplash.splashFactory,
                        onTap: (() {
                          setState(() {
                            _isUser = true;
                            _isRider = false;
                          });
                        }),
                        child: Column(
                          children: [
                            FittedBox(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      right: 5,
                                      left: 180,
                                      top: 5,
                                    ),
                                    child: Icon(
                                      _isUser
                                          ? Icons.check_circle
                                          : Icons.circle_outlined,
                                      size: 25,
                                      color: _isUser
                                          ? const Color.fromRGBO(220, 20, 60, 1)
                                          : Colors.grey,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 20, bottom: 10),
                              child: CircleAvatar(
                                  radius: 27,
                                  child: Icon(
                                    Icons.person,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  backgroundColor:
                                      const Color.fromARGB(255, 241, 198, 207)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 8, right: 20, top: 5),
                              child: Text('User',
                                  style: GoogleFonts.inter(
                                      textStyle: const TextStyle(
                                          fontFamily: 'RobotoCondensed',
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black))),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 350),
                width: 300,
                height: 50,
                child: ElevatedButton(
                  onPressed: (() {
                    if (_isRider) {
                      Navigator.pushNamed(context, LoginSignupAlert.routeName);
                    }
                  }),
                  child: const Text(
                    'Select',
                    style: TextStyle(
                        fontFamily: 'RobotoCondensed',
                        fontSize: 20,
                        color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
