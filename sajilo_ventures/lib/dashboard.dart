import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:sajilo_ventures/helper/analytics_item.dart';
import 'package:sajilo_ventures/widgets/dashboard_filter_dropdown.dart';
import 'package:sajilo_ventures/widgets/graph_builder.dart';
import 'package:sajilo_ventures/widgets/grid_item.dart';
import 'package:sajilo_ventures/widgets/growth_loss_indicator.dart';
import 'package:sajilo_ventures/widgets/radio_component.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int val = -1;
  @override
  Widget build(BuildContext context) {
    final List<AnalyticsItem> _loadedItems =
        Provider.of<AnalyticsHelper>(context).items;
    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 0.0,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 12,
            )),
        backgroundColor: Colors.white,
        title: const Text('Dashboard'),
        centerTitle: true,
        titleTextStyle: Theme.of(context).textTheme.headline1,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const <Widget>[
                DashboardFilterDropDown(),
                GrowthLossIndicator(),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(left: 20),
              width: double.infinity,
              height: 300,
              child: const GraphBuilder(),
            ),
            const RadioComponent(),
            Container(
              padding: const EdgeInsets.only(left: 20, top: 5),
              alignment: Alignment.centerLeft,
              child: const Text(
                'Analytics',
                style: TextStyle(
                    fontFamily: 'RobotoCondensed',
                    fontWeight: FontWeight.w800,
                    fontSize: 17),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              height: 220,
              width: 400,
              child: GridView.builder(
                  primary: false,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 88,
                    childAspectRatio: 2 / 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemCount: _loadedItems.length,
                  itemBuilder: (_, index) {
                    return Column(
                      children: [
                        GridItems(_loadedItems[index].title,
                            _loadedItems[index].number),
                      ],
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    'Pay you ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
                  ),
                  Text('Fare',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: Color.fromARGB(255, 179, 36, 55))),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 20, top: 5),
              child: const Text(
                'Note: If the amount exceed more than Rs. 1000 then you won\'t be able to go online and start using our service.',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontFamily: 'RobotoCondensed',
                    color: Color.fromARGB(255, 136, 134, 134),
                    fontSize: 16),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: 350,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text(
                  'Pay',
                  style: TextStyle(
                      fontFamily: 'RobotoCondensed',
                      fontSize: 20,
                      color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
              ),
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
