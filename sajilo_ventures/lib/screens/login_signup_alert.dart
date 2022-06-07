import 'package:firebase_auth/firebase_auth.dart';

import 'dashboard.dart';
import 'ride_registration.dart';

import 'package:flutter/material.dart';

class LoginSignupAlert extends StatefulWidget {
  static const routeName = 'alert';

  const LoginSignupAlert({Key? key}) : super(key: key);

  @override
  State<LoginSignupAlert> createState() => _LoginSignupAlertState();
}

class _LoginSignupAlertState extends State<LoginSignupAlert> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _isloading = false;
  final _auth = FirebaseAuth.instance;
  var _email = '';
  var _password = '';
  var _phone = '';
  var _username = '';

  void _findaccount() async {
    final _isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (_isValid) {
      _formKey.currentState!.save();
      try {
        if (_isLogin) {
          setState(() {
            _isloading = true;
          });
          final authResult = await _auth.signInWithEmailAndPassword(
              email: _email, password: _password);
          setState(() {
            _isloading = false;
          });
          Navigator.pushNamed(context, Dashboard.routeName);
        } else {
          setState(() {
            _isloading = true;
          });
          final authResult = await _auth.createUserWithEmailAndPassword(
              email: _email, password: _password);
          setState(() {
            _isloading = false;
          });
          Navigator.pushNamed(context, RideRegistration.routeName,
              arguments: authResult.user!.uid);
        }
      } catch (error) {
        print(error);
        setState(() {
          _isloading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(_validator(error.toString())),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ));
      }
    }
  }

  String _validator(String raw) {
    String result;
    RegExp regExp = RegExp(r'^(\[.*\])(.*)$');

    final RegExpMatch? match = regExp.firstMatch(raw);

    if (match?.group(1) == null) {
      result = raw;
    } else {
      result = match!.group(2).toString();
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 0.0,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 15,
            )),
        backgroundColor: Colors.white,
        title: Text(_isLogin ? 'Login to your Account' : 'Create an Account'),
        centerTitle: true,
        titleTextStyle: Theme.of(context).textTheme.headline1,
      ),
      body: AlertDialog(
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
              if (!_isLogin)
                Column(
                  children: [
                    TextFormField(
                      autofocus: false,
                      key: const ValueKey('username'),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 8) {
                          return 'Please provide a username.';
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                          labelText: 'Create a username.'),
                      onSaved: (value) {
                        _username = value!;
                      },
                    ),
                    TextFormField(
                      autofocus: false,
                      maxLength: 10,
                      key: const ValueKey('phone'),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value!.isEmpty || value.length < 10) {
                          return 'Number must be of 10-digits.';
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                          labelText: 'Enter your phone number.'),
                      onSaved: (value) {
                        _phone = value!;
                      },
                    ),
                  ],
                ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: 250,
                height: 50,
                child: ElevatedButton(
                  onPressed: (() {
                    _findaccount();
                  }),
                  child: _isloading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text(
                          _isLogin ? 'Log in' : 'Sign up',
                          style: const TextStyle(
                              fontFamily: 'RobotoCondensed',
                              fontSize: 20,
                              color: Colors.white),
                        ),
                  style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
                ),
              ),
              TextButton(
                  onPressed: () {
                    setState(() {
                      _isLogin = !_isLogin;
                    });
                  },
                  child: Text(_isLogin
                      ? 'I don\'t have an account.Create one?'
                      : 'I already have an account')),
            ],
          ),
        ),
      ),
    );
  }
}
