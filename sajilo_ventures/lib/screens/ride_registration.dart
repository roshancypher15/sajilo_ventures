import 'package:flutter/material.dart';

import '../widgets/vehicle_dropdown.dart';
import '../widgets/image_input.dart';

class RideRegistration extends StatefulWidget {
  static const routeName = 'rider-registration';
  const RideRegistration({Key? key}) : super(key: key);

  @override
  State<RideRegistration> createState() => _RideRegistrationState();
}

class _RideRegistrationState extends State<RideRegistration> {
  final formkey = GlobalKey<FormState>();
  final _vehicleModelController = TextEditingController();
  final _registrationNumberController = TextEditingController();
  final _drivingLicenseController = TextEditingController();
  final _numberplatefocusnode = FocusNode();

  Future<void> _submit() async {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        context: context,
        builder: (builder) {
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
                            'We will need to verify your vehicle for authenticity and security purpose.Be sure to upload genuine documents.',
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
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Done',
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
                          children: const <Widget>[
                            Text(
                              '  Vehicle',
                              style: TextStyle(
                                  fontFamily: 'RobotoCondensed',
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            VehicleDropDown(),
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
                            TextField(
                                controller: _vehicleModelController,
                                textInputAction: TextInputAction.next,
                                maxLines: 1,
                                onSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(_numberplatefocusnode);
                                },
                                decoration: InputDecoration(
                                    hintText: 'eg. Bajaj Pulsar NS 200',
                                    contentPadding: const EdgeInsets.all(15),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(35))),
                                onChanged: (value) {}),
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
                            TextField(
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
                                onChanged: (value) {}),
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
                        const ImageInput(150, 350, 'Upload Document'),
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
                            TextField(
                                controller: _drivingLicenseController,
                                textInputAction: TextInputAction.done,
                                maxLines: 1,
                                decoration: InputDecoration(
                                    hintText: 'eg. 1234567',
                                    contentPadding: const EdgeInsets.all(15),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(35))),
                                onChanged: (value) {}),
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
                                  children: const <Widget>[
                                    ImageInput(150, 150, 'Upload Front'),
                                    ImageInput(150, 150, 'Upload Back'),
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
                        const ImageInput(150, 350, 'Upload Document'),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 300,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: _submit,
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
