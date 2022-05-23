import 'package:flutter/cupertino.dart';

class AnalyticsItem {
  final String title;
  final int number;
  AnalyticsItem({required this.title, required this.number});
}

class AnalyticsHelper with ChangeNotifier {
  final List<AnalyticsItem> _items = [
    AnalyticsItem(title: 'Total Earnings(Rs.)', number: 15000),
    AnalyticsItem(title: 'Total Fare(Rs.)', number: 735),
    AnalyticsItem(title: 'Request Recieved', number: 25),
    AnalyticsItem(title: 'Request Accepted', number: 24),
  ];
  List<AnalyticsItem> get items {
    return [..._items];
  }
}
