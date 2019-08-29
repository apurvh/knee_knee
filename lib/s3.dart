import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
//import 'package:charts_flutter/flutter.dart';

class S3 extends StatefulWidget {
  @override
  _S3State createState() => _S3State();
}

class _S3State extends State<S3> {
//  static List<charts.Series<LinearSales, int>> _createSampleData() {
//    final data = [
//      new LinearSales(0, 5),
//      new LinearSales(1, 25),
//      new LinearSales(2, 100),
//      new LinearSales(3, 75),
//    ];
//
//    return [
//      new charts.Series<LinearSales, int>(
//        id: 'Sales',
//        domainFn: (LinearSales sales, _) => sales.year,
//        measureFn: (LinearSales sales, _) => sales.sales,
//        data: data,
//      )
//    ];
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/screen_s1.jpg"),
//              image: AssetImage("assets/img/knee_animation.gif"),
            fit: BoxFit.cover,
          ),
        ),
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                Card(
                  elevation: 1.0,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
                      width: 300,
                      height: 300,
                      child: SimpleLineChart.withSampleData(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
//              Text(
//                "Congratulations !",
//                style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.green[700]),
//              ),
                Text(
                  "Your session is complete.",
                  style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.normal,color: Colors.green[700]),
                ),
                Text("Max Value: 12",
                  style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold,color: Colors.green[700]),
                ),
                SizedBox(
                  height: 15,
                ),
                RaisedButton(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.done,color: Colors.green,),
                        Text("  Done",style: TextStyle(color: Colors.green),),
                      ],
                    ),
                  ),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
//      Column(
//        crossAxisAlignment: CrossAxisAlignment.center,
//        mainAxisAlignment: MainAxisAlignment.center,
//        children: <Widget>[
//          Center(child: Text("TBDXX")),
//          SimpleLineChart.withSampleData()
//        ],
//      ),
    );
  }
}

class SimpleLineChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SimpleLineChart(this.seriesList, {this.animate});

  /// Creates a [LineChart] with sample data and no transition.
  factory SimpleLineChart.withSampleData() {
    return new SimpleLineChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.LineChart(seriesList, animate: animate);
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final data = [
      new LinearSales(0, 5),
      new LinearSales(1, 25),
      new LinearSales(2, 100),
      new LinearSales(3, 75),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}
