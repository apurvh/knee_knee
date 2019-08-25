import 'package:flutter/material.dart';
import 'package:knee_knee/s2.dart';
import 'package:knee_knee/s4.dart';

class S1 extends StatefulWidget {
  @override
  _S1State createState() => _S1State();
}

class _S1State extends State<S1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        // Here we take the value from the MyHomePage object that was created by
//        // the App.build method, and use it to set our appbar title.
//        title: Text(widget.title),
//      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Column(
            // Column is also layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Invoke "debug painting" (press "p" in the console, choose the
            // "Toggle Debug Paint" action from the Flutter Inspector in Android
            // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
            // to see the wireframe for each widget.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            mainAxisAlignment: MainAxisAlignment.center,

            children: <Widget>[
              Card(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 18.0, bottom: 18.0, right: 8.0, left: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                        width: 130.0,
                        height: 130.0,
                        decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          image: new DecorationImage(
                            fit: BoxFit.fill,
                            image: new AssetImage(
                              'assets/img/dp.jpg',
                            ),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("  Deepika Padukon "),
                          SizedBox(
                            height: 20,
                          ),
                          Text("  Female      "),
                          SizedBox(
                            height: 20,
                          ),
                          Text("  18      "),
                        ],
                      )
                    ],
                  ),
                ),
                elevation: 2.0,
                margin: EdgeInsets.all(20.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              SizedBox(
                height: 80,
              ),
              RaisedButton(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text("       Records      "),
                  ),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => S4(),
                      ),);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0))),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text("          Start          "),
                  ),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => S2(),
                      ),);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0))),
//            Text(
//              'You have pushed the button this many times:',
//            ),
//            Text(
//              '$_counter',
//              style: Theme.of(context).textTheme.display1,
//            ),
            ],
          ),
        ),
      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: _incrementCounter,
//        tooltip: 'Increment',
//        child: Icon(Icons.add),
//      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
