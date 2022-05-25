import 'package:flutter/cupertino.dart';
import 'package:date_time_format/date_time_format.dart';

class TripItem {
  String tripId;
  String tripdate;
  String pickupLocation;
  String destination;
  int tripCost;
  int tripTime;
  double distance;
  double tripRating;
  String imageUrl;
  String name;
  TripItem(
      {required this.name,
      required this.tripId,
      required this.tripdate,
      required this.pickupLocation,
      required this.destination,
      required this.tripCost,
      required this.tripTime,
      required this.distance,
      required this.tripRating,
      required this.imageUrl});
}

class AllTripsHelper with ChangeNotifier {
  final List<TripItem> _trips = [
    TripItem(
        name: 'Prabal Rai',
        tripId: '#lkhfyt',
        tripdate:
            DateTimeFormat.format(DateTime.now(), format: 'M j, Y, H:i A'),
        pickupLocation: 'New Baneshowr,Kathmandu',
        destination: 'Learning Realm International School, Kalanki',
        tripCost: 185,
        distance: 5.4,
        tripTime: 40,
        tripRating: 0,
        imageUrl:
            'https://cdn.pixabay.com/photo/2021/01/29/08/08/dog-5960092_960_720.jpg'),
    TripItem(
        name: 'Prabal Rai',
        tripId: '#putgsh',
        tripdate:
            DateTimeFormat.format(DateTime.now(), format: 'M j, Y, H:i A'),
        pickupLocation: 'Sanga,Bhaktapur',
        destination: 'NASA Intl College,Gairigaun,Tinkune',
        tripCost: 75,
        distance: 2,
        tripTime: 12,
        tripRating: 0,
        imageUrl:
            'https://cdn.pixabay.com/photo/2021/08/27/13/33/lionel-messi-6578685_960_720.jpg'),
    TripItem(
        name: 'Prabal Rai',
        tripId: '#khydth',
        tripdate:
            DateTimeFormat.format(DateTime.now(), format: 'M j, Y, H:i A'),
        pickupLocation: 'Naya Thimi,Bhaktapur',
        destination: 'Bhagwati Marg, Naxal',
        tripCost: 149,
        distance: 3.5,
        tripTime: 9,
        tripRating: 0,
        imageUrl:
            'https://cdn.pixabay.com/photo/2021/08/27/13/33/lionel-messi-6578685_960_720.jpg'),
    TripItem(
        name: 'Prabal Rai',
        tripId: '#hsyusk',
        tripdate:
            DateTimeFormat.format(DateTime.now(), format: 'M j, Y, H:i A'),
        pickupLocation: 'Krishna Mandir,Patan',
        destination: 'Chandragiri Cable Car,Chandragiri',
        tripCost: 200,
        tripTime: 27,
        distance: 1.2,
        tripRating: 0,
        imageUrl:
            'https://cdn.pixabay.com/photo/2021/01/29/08/08/dog-5960092_960_720.jpg')
  ];

  List<TripItem> get items {
    return [..._trips];
  }

  TripItem trip(String Id) {
    return items.firstWhere((element) => element.tripId == Id);
  }

  void update(String id, double rating) {
    final index = _trips.indexWhere((element) => element.tripId == id);
    _trips[index] = TripItem(
        name: _trips[index].name,
        tripId: _trips[index].tripId,
        tripdate: _trips[index].tripdate,
        pickupLocation: _trips[index].pickupLocation,
        destination: _trips[index].destination,
        tripCost: _trips[index].tripCost,
        tripTime: _trips[index].tripTime,
        distance: _trips[index].distance,
        tripRating: rating,
        imageUrl: _trips[index].imageUrl);
    notifyListeners();
  }

  double getRating(String id) {
    final data = _trips.firstWhere((element) => element.tripId == id);
    return data.tripRating;
  }
}
