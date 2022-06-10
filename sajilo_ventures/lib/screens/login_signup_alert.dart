import 'package:firebase_auth/firebase_auth.dart';
import '../hide_password_icons.dart';

import 'dashboard.dart';
import 'ride_registration.dart';

import 'package:flutter/material.dart';

class LoginSignupAlert extends StatefulWidget {
  static const routeName = 'alert';

  const LoginSignupAlert({Key? key}) : super(key: key);

  @override
  State<LoginSignupAlert> createState() => _LoginSignupAlertState();
}

class _LoginSignupAlertState extends State<LoginSignupAlert>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _passwordTextEditor = TextEditingController();
  var _isLogin = true;
  var _isloading = false;
  final _auth = FirebaseAuth.instance;
  var _email = '';
  var _password = '';

  var _phone = '';
  var _username = '';
  var _hidepassword = true;
  var _hideConfirmPassword = true;
  late AnimationController _controller;

  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation1;
  late Animation<Offset> _slideAnimation2;
  void togglePassword() {
    setState(() {
      _hidepassword = !_hidepassword;
    });
  }

  void toggleConfirmPassword() {
    setState(() {
      _hideConfirmPassword = !_hideConfirmPassword;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn));
    _slideAnimation1 = Tween(
            begin: const Offset(0, -0.15), end: const Offset(0, 0))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _slideAnimation2 = Tween(
            begin: const Offset(0, -0.30), end: const Offset(0, 0))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    super.initState();
  }

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
          Navigator.pushNamed(context, RideRegistration.routeName, arguments: {
            'uid': authResult.user!.uid,
            'email': authResult.user!.email,
            'phone': _phone,
            'username': _username,
            'password': _password.toString()
          });
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
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: _isLogin ? 150 : 50, left: 10),
          child: Card(
            borderOnForeground: true,
            elevation: 6,
            shadowColor: Colors.transparent,
            child: AnimatedContainer(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                    width: 1, color: Theme.of(context).colorScheme.secondary),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: 360,
              constraints: BoxConstraints(minHeight: _isLogin ? 220 : 350),
              curve: Curves.fastOutSlowIn,
              duration: const Duration(milliseconds: 400),
              child: Form(
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
                          labelText: 'Enter your login e-mail',
                          labelStyle: TextStyle(fontSize: 16)),
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (value) {
                        _email = value!;
                      },
                    ),
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        TextFormField(
                          autofocus: false,
                          controller: _passwordTextEditor,
                          keyboardType: TextInputType.emailAddress,
                          key: const ValueKey('password'),
                          validator: (value) {
                            if (value!.isEmpty || value.length < 8) {
                              return 'Password must be 8-characters';
                            }
                            {
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                              labelText: 'Enter a Password',
                              labelStyle: TextStyle(fontSize: 16)),
                          obscureText: _hidepassword,
                          onSaved: (value) {
                            _password = value!;
                          },
                        ),
                        IconButton(
                            onPressed: togglePassword,
                            icon: Icon(_hidepassword
                                ? Icons.remove_red_eye
                                : HidePassword.hide_password)),
                      ],
                    ),
                    if (!_isLogin)
                      Column(
                        children: [
                          FadeTransition(
                            opacity: _opacityAnimation,
                            child: SlideTransition(
                              position: _slideAnimation1,
                              child: Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  TextFormField(
                                    autofocus: false,
                                    obscureText: _hideConfirmPassword,
                                    decoration: const InputDecoration(
                                        labelText: 'Confirm your Password',
                                        labelStyle: TextStyle(fontSize: 16)),
                                    key: const ValueKey('confirmPassword'),
                                    validator: (value) {
                                      if (_passwordTextEditor.text != value) {
                                        return 'Password doesn\'t match.';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                  IconButton(
                                      onPressed: toggleConfirmPassword,
                                      icon: Icon(_hideConfirmPassword
                                          ? Icons.remove_red_eye
                                          : HidePassword.hide_password)),
                                ],
                              ),
                            ),
                          ),
                          FadeTransition(
                            opacity: _opacityAnimation,
                            child: SlideTransition(
                              position: _slideAnimation1,
                              child: TextFormField(
                                autofocus: false,
                                decoration: const InputDecoration(
                                    labelText: 'Username',
                                    labelStyle: TextStyle(fontSize: 16)),
                                key: const ValueKey('username'),
                                validator: (value) {
                                  if (value!.isEmpty || value.length < 8) {
                                    return 'Please provide a username.';
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (value) {
                                  _username = value!;
                                },
                              ),
                            ),
                          ),
                          FadeTransition(
                            opacity: _opacityAnimation,
                            child: SlideTransition(
                              position: _slideAnimation2,
                              child: TextFormField(
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
                                    labelText: 'Enter a phone number',
                                    labelStyle: TextStyle(fontSize: 16)),
                                onSaved: (value) {
                                  _phone = value!;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    Hero(
                      tag: 'button',
                      child: Container(
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
                          style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder()),
                        ),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            _isLogin
                                ? _controller.forward()
                                : _controller.reverse();

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
          ),
        ),
      ),
    );
  }
}
