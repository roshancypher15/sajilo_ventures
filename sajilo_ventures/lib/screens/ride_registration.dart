import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sajilo_ventures/screens/dashboard.dart';

import '../widgets/vehicle_dropdown.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import '../widgets/image_input.dart';

class RideRegistration extends StatefulWidget {
  static const routeName = 'rider-registration';
  const RideRegistration({Key? key}) : super(key: key);

  @override
  State<RideRegistration> createState() => _RideRegistrationState();
}

class _RideRegistrationState extends State<RideRegistration> {
  var _isSigninUp = false;
  final formkey = GlobalKey<FormState>();
  final _vehicleModelController = TextEditingController();
  final _registrationNumberController = TextEditingController();
  final _drivingLicenseController = TextEditingController();
  final _numberplatefocusnode = FocusNode();
  var _vehicleModel = '';
  var _vehicleRegistrationNumber = '';
  var _licenseNumber = '';
  var _vehicleType = '';
  late Map<String, dynamic> _userInfo;
  File? _vehicleRegistationDocumentImage;
  File? _drivingLicenseFrontImage;
  File? _drivinglicenseBackImage;
  File? _vehicleImage;
  final _firestore = FirebaseFirestore.instance;

  @override
  void didChangeDependencies() {
    _userInfo =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    print(_userInfo['uid']);
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  void getVehicleTypeFromChild(newString) {
    setState(() {
      _vehicleType = newString;
    });
  }

  bool validData() {
    final isvalid = (formkey.currentState!.validate() &&
        _vehicleRegistationDocumentImage != null &&
        _drivingLicenseFrontImage != null &&
        _drivinglicenseBackImage != null &&
        _vehicleImage != null);

    if (isvalid) {
      return isvalid;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text(
          'Please, Provide all necessary informations and documents.',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ));
      return isvalid;
    }
  }

  void initiateUpload() async {
    formkey.currentState!.save();

    setState(() {
      _isSigninUp = true;
    });
    final ref1 = FirebaseStorage.instance
        .ref()
        .child('user_images')
        .child(_userInfo['uid'])
        .child('vehicleRegistationDocumentImage.jpg');

    final ref2 = FirebaseStorage.instance
        .ref()
        .child('user_images')
        .child(_userInfo['uid'])
        .child('drivingLicenseFront.jpg');

    final ref3 = FirebaseStorage.instance
        .ref()
        .child('user_images')
        .child(_userInfo['uid'])
        .child('drivinglicenseBackImage.jpg');

    final ref4 = FirebaseStorage.instance
        .ref()
        .child('user_images')
        .child(_userInfo['uid'])
        .child('vehicleImage.jpg');
    await ref1.putFile(_vehicleRegistationDocumentImage!);
    await ref2.putFile(_drivingLicenseFrontImage!);
    await ref3.putFile(_drivinglicenseBackImage!);
    await ref4.putFile(_vehicleImage!);
    final vehicleDocumentURL = await ref1.getDownloadURL();
    final drivingLicenseFrontURl = await ref2.getDownloadURL();
    final drivingLicenseBackURL = await ref3.getDownloadURL();
    final vehiclePhotoURL = await ref4.getDownloadURL();

    await _firestore.collection('allRiders').doc(_userInfo['uid']).set({
      'email': _userInfo['email'],
      'password': _userInfo['password'],
      'username': _userInfo['username'],
      'phone': _userInfo['phone'],
      'vehicleType': _vehicleType,
      'vehicleModel': _vehicleModel,
      'vehicleRegistrationNumber': _vehicleRegistrationNumber,
      'licenseNumber': _licenseNumber,
      'vehicleDocumentURL': vehicleDocumentURL,
      ' drivingLicenseFrontURl': drivingLicenseFrontURl,
      'drivingLicenseBackURL': drivingLicenseBackURL,
      'vehiclePhotoURL': vehiclePhotoURL,
    });
    setState(() {
      _isSigninUp = false;
    });
    Navigator.of(context).pushReplacementNamed(Dashboard.routeName);
  }

  void vehicleRegistrationDocument(File image) {
    setState(() {
      _vehicleRegistationDocumentImage = image;
    });
  }

  void drivingLicenseFront(File image) {
    setState(() {
      _drivingLicenseFrontImage = image;
    });
  }

  void drivingLicenseBack(File image) {
    setState(() {
      _drivinglicenseBackImage = image;
    });
  }

  void vehiclePhoto(File image) {
    _vehicleImage = image;
  }

  Future<void> _submit() async {
    showModalBottomSheet(
        enableDrag: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        context: context,
        builder: (builder) {
          return StatefulBuilder(builder: (context, setState) {
            return Container(
                margin: const EdgeInsets.all(15),
                height: 200.0,
                width: 300,
                color: Colors.transparent,
                child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        const Text(
                          'Register Your Vehicle',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'RobotoCondensed',
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
                        Center(
                          child: Container(
                            width: 320,
                            child: const Text(
                              'We will need to verify your vehicle for authenticity and security purpose.Register if you wish to continue.',
                              style: TextStyle(fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Container(
                          width: 300,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              initiateUpload();
                            },
                            child: _isSigninUp
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
                                    'Register',
                                    style: TextStyle(
                                        fontFamily: 'RobotoCondensed',
                                        fontSize: 18,
                                        color: Colors.white),
                                  ),
                            style: ElevatedButton.styleFrom(
                                shape: const StadiumBorder()),
                          ),
                        ),
                      ],
                    )));
          });
        });
  }

  @override
  void dispose() {
    _numberplatefocusnode.dispose();

    super.dispose();
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
        title: const Text('Ride Registration'),
        centerTitle: true,
        titleTextStyle: Theme.of(context).textTheme.headline1,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: 400,
              height: 300,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                child: Image.asset(
                  'images/vector.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Center(
              child: Text(
                'Begin your Rider journey with us.\n           Sign up Today!',
                style: TextStyle(fontFamily: 'Raleway', fontSize: 16),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Form(
              key: formkey,
              child: Card(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15))),
                  elevation: 20,
                  shadowColor: const Color.fromARGB(255, 207, 204, 204),
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 20,
                        ),
                        const Center(
                          child: Text(
                            'Register your Vehicle',
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'RobotoCondensed',
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Center(
                          child: Text(
                            'We will need to verify your vehicle for authenticity and security purpose.Be sure to upload genuine documents.',
                            style: TextStyle(
                              color: Color.fromARGB(255, 138, 136, 136),
                              fontSize: 16,
                              fontFamily: 'Raleway',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              '  Vehicle',
                              style: TextStyle(
                                  fontFamily: 'RobotoCondensed',
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            VehicleDropDown(getVehicleTypeFromChild),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              '  Vehicle Model',
                              style: TextStyle(
                                  fontFamily: 'RobotoCondensed',
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                                controller: _vehicleModelController,
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value!.isEmpty || value.length < 5) {
                                    return 'Please specify your vehicle model.';
                                  }
                                  return null;
                                },
                                maxLines: 1,
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(_numberplatefocusnode);
                                  
                                },
                                decoration: InputDecoration(
                                    hintText: 'eg. Bajaj Pulsar NS 200',
                                    contentPadding: const EdgeInsets.all(15),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(35))),
                                onSaved: (value) {
                                  _vehicleModel = value!;
                                }),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              '  Vehicle Registration Number',
                              style: TextStyle(
                                  fontFamily: 'RobotoCondensed',
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty || value.length < 10) {
                                    return 'Please enter valid vehicle number.';
                                  }
                                  return null;
                                },
                                controller: _registrationNumberController,
                                focusNode: _numberplatefocusnode,
                                textInputAction: TextInputAction.done,
                                maxLines: 1,
                                decoration: InputDecoration(
                                    hintText: 'Vehicle Number Plate',
                                    contentPadding: const EdgeInsets.all(15),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(35))),
                                onSaved: (value) {
                                  _vehicleRegistrationNumber = value!;
                                }),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.only(bottom: 5, left: 5),
                          child: const Text(
                            'Vehicle Registration Document',
                            style: TextStyle(
                                fontFamily: 'RobotoCondensed',
                                fontSize: 17,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        ImageInput(150, 350, 'Upload Document',
                            vehicleRegistrationDocument),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              ' Driving License Number',
                              style: TextStyle(
                                  fontFamily: 'RobotoCondensed',
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty || value.length < 8) {
                                    return 'Please provide valid license number.';
                                  }
                                  return null;
                                },
                                controller: _drivingLicenseController,
                                textInputAction: TextInputAction.done,
                                onFieldSubmitted: (value) {
                                  FocusScope.of(context).unfocus();
                                },
                                maxLines: 1,
                                decoration: InputDecoration(
                                    hintText: 'eg. 1234567',
                                    contentPadding: const EdgeInsets.all(15),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(35))),
                                onSaved: (value) {
                                  _licenseNumber = value!;
                                }),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Text(
                                  '  Driving License Documents',
                                  style: TextStyle(
                                      fontFamily: 'RobotoCondensed',
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    ImageInput(150, 150, 'Upload Front',
                                        drivingLicenseFront),
                                    ImageInput(150, 150, 'Upload Back',
                                        drivingLicenseBack),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.only(bottom: 5, left: 5),
                          child: const Text(
                            'Vehicle Photo',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontFamily: 'RobotoCondensed',
                                fontSize: 17,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        ImageInput(150, 350, 'Upload Document', vehiclePhoto),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 300,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              final confirmValidation = validData();
                              if (confirmValidation) {
                                _submit();
                              }
                            },
                            child: const Text(
                              'Register',
                              style: TextStyle(
                                  fontFamily: 'RobotoCondensed',
                                  fontSize: 20,
                                  color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                                shape: const StadiumBorder()),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
