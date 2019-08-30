import 'package:flutter/material.dart';

//import 'package:path_provider/path_provider.dart';

import 'package:charts_flutter/flutter.dart' as charts;
//import 'package:knee_knee/main.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

List dataFiles = new List();
int dataFilesLength;

class S4 extends StatefulWidget {
  @override
  _S4State createState() => _S4State();
}

class _S4State extends State<S4> {

  @override
  void initState() {
    getDataFromDir();
    super.initState();

  }

  getDataFromDir() async {
    Directory appDocDir = await getApplicationDocumentsDirectory() ;
    String appDocDirPath = appDocDir.path +"/dd";

    List file = new List();
    file = Directory(appDocDirPath).listSync();

//    print(file[0].toString()+file.length.toString());
    dataFilesLength = file.length;
    print("dataFilesLength: $dataFilesLength");

    for(int i=0;i<file.length;i++){
      print("name of file $i : ${file[i]}");
      String text = await file[i].readAsString();
      dataFiles.add(text);
    }

    print("...big array data: $dataFiles");

  }

  bool loading = true;
  @override
  Widget build(BuildContext context) {

    if(loading == true){
      Future.delayed(const Duration(milliseconds: 1000), () {
        setState(() {
          print("...loading....");
          loading = false;
        });
      });

      return Scaffold(
        body: Center(child: Text("Loading...")),
      );
    }
    else {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/screen_s1.jpg"),
//              image: AssetImage("assets/img/knee_animation.gif"),
                fit: BoxFit.cover,
              ),
            ),
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Card(
                      elevation: 1.0,
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Container(
                          width: 300,
                          height: 300,
                          child: DisjointMeasureAxisLineChart.withSampleData(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Improvement Chart"),
                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.done,
                              color: Colors.green,
                            ),
                            Text(
                              "  Done",
                              style: TextStyle(color: Colors.green),
                            ),
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
        ),
      );
    }
  }
}

class DisjointMeasureAxisLineChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  DisjointMeasureAxisLineChart(this.seriesList, {this.animate});

  /// Creates a [LineChart] with sample data and no transition.
  factory DisjointMeasureAxisLineChart.withSampleData() {
    return new DisjointMeasureAxisLineChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.LineChart(seriesList,
        defaultRenderer:
            new charts.LineRendererConfig(includeArea: true, stacked: true),
        animate: animate);
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createSampleData() {



    final myFakeDesktopData = [
      new LinearSales(0, 0),
    ];

    for (int i = 1; i < 520; i++) {
      int parsedData = double.parse(dataFiles[dataFilesLength-3].toString().split(",")[i].toString()).toInt();
      myFakeDesktopData.add(new LinearSales(i, parsedData));
    }

    var myFakeTabletData = [
      new LinearSales(0, 0),
    ];
    for (int i = 1; i < 520; i++) {
      int parsedData = double.parse(dataFiles[dataFilesLength-2].toString().split(",")[i].toString()).toInt();
      myFakeTabletData.add(new LinearSales(i, parsedData));
    }

    var myFakeMobileData = [
      new LinearSales(0, 0),
    ];
    for (int i = 1; i < 520; i++) {
      int parsedData = double.parse(dataFiles[dataFilesLength-1].toString().split(",")[i].toString()).toInt();
      myFakeMobileData.add(new LinearSales(i, parsedData));
    }

    return [
      new charts.Series<LinearSales, int>(
        id: 'Desktop',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: myFakeDesktopData,
      ),
      new charts.Series<LinearSales, int>(
        id: 'Tablet',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: myFakeTabletData,
      ),
      new charts.Series<LinearSales, int>(
        id: 'Mobile',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: myFakeMobileData,
      ),
    ];
  }
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}
