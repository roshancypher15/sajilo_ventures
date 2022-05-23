import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class GraphBuilder extends StatefulWidget {
  const GraphBuilder({Key? key}) : super(key: key);

  @override
  State<GraphBuilder> createState() => _GraphBuilderState();
}

class _GraphBuilderState extends State<GraphBuilder> {
  late List<charts.Series<Sales, int>> _seriesLineData;
  _generateData() {
    var linesalesdata = [
      Sales(0, 45),
      Sales(1, 56),
      Sales(2, 55),
      Sales(3, 60),
      Sales(4, 61),
      Sales(5, 70),
    ];
    var linesalesdata1 = [
      Sales(0, 35),
      Sales(1, 46),
      Sales(2, 45),
      Sales(3, 50),
      Sales(4, 51),
      Sales(5, 60),
    ];
    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff990099)),
        id: 'Air Pollution',
        data: linesalesdata,
        domainFn: (Sales sales, _) => sales.yearval,
        measureFn: (Sales sales, _) => sales.salesval,
      ),
    );
    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff109618)),
        id: 'Air Pollution',
        data: linesalesdata1,
        domainFn: (Sales sales, _) => sales.yearval,
        measureFn: (Sales sales, _) => sales.salesval,
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _seriesLineData = <charts.Series<Sales, int>>[];
    _generateData();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Container(
              padding: const EdgeInsets.only(right: 20),
              height: 300,
              width: double.infinity,
              child: charts.LineChart(
                _seriesLineData,
                defaultRenderer:
                    charts.LineRendererConfig(includeArea: true, stacked: true),
                animate: false,
                // behaviors: [
                //   charts.ChartTitle('',
                //       behaviorPosition: charts.BehaviorPosition.bottom,
                //       titleOutsideJustification:
                //           charts.OutsideJustification.middleDrawArea),
                //   charts.ChartTitle('',
                //       behaviorPosition: charts.BehaviorPosition.start,
                //       titleOutsideJustification:
                //           charts.OutsideJustification.middleDrawArea),
                // ]),
              )),
        ],
      ),
    );
  }
}

class Sales {
  int yearval;
  int salesval;

  Sales(this.yearval, this.salesval);
}
