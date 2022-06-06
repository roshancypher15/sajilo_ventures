import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sajilo_ventures/screens/dashboard.dart';
import 'package:sajilo_ventures/screens/ride_registration.dart';

class UserOrRider extends StatefulWidget {
  const UserOrRider({Key? key}) : super(key: key);

  @override
  State<UserOrRider> createState() => _UserOrRiderState();
}

class _UserOrRiderState extends State<UserOrRider> {
  var _isRider = false;
  var _isUser = false;
  var _error = false;
  var _isLogin = true;
  final _formKey = GlobalKey<FormState>();
  var _email = '';
  var _password = '';

  //
  final _auth = FirebaseAuth.instance;

//
//

  void _findaccount(BuildContext context) async {
    final _isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (_isValid) {
      _formKey.currentState!.save();
      try {
        if (_isLogin) {
          final authresult = await _auth.signInWithEmailAndPassword(
              email: _email, password: _password);
          Navigator.pushNamed(context, Dashboard.routeName);
        } else {
          await _auth.createUserWithEmailAndPassword(
              email: _email, password: _password);
          Navigator.pushNamed(context, RideRegistration.routeName);
        }
      } catch (error) {
        print(error);
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Couldn\'t find Your account.'),
          backgroundColor: Theme.of(context).errorColor,
        ));
      }
    }
  }

  // String _validator(String raw) {
  //   String result;
  //   RegExp regExp = RegExp(r'^(\[.*\])(.*)$');

  //   final RegExpMatch? match = regExp.firstMatch(raw);

  //   if (match?.group(1) == null) {
  //     result = raw;
  //   } else {
  //     result = match!.group(2).toString();
  //   }
  //   return result;
  // }

  _showdialog() async {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return AlertDialog(
              content: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      autofocus: false,
                      key: const ValueKey('email'),
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@gmail.com')) {
                          return 'Please enter a valid email';
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                          labelText: 'Enter valid e-mail address.'),
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (value) {
                        _email = value!;
                      },
                    ),
                    TextFormField(
                      autofocus: false,
                      key: const ValueKey('password'),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 8) {
                          return 'Password must be 8-characters';
                        } else {
                          return null;
                        }
                      },
                      decoration:
                          const InputDecoration(labelText: 'Enter a password.'),
                      obscureText: true,
                      onSaved: (value) {
                        _password = value!;
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: 250,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: (() {
                          _findaccount(context);
                        }),
                        child: Text(
                          _isLogin ? 'Log in' : 'Sign up',
                          style: const TextStyle(
                              fontFamily: 'RobotoCondensed',
                              fontSize: 20,
                              color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder()),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                        child: Text(_isLogin
                            ? 'Create an account.'
                            : 'I already have an account')),
                  ],
                ),
              ),
            );
          });
        });
  }

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
                      _showdialog();
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
