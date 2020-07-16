
import 'package:flutter/material.dart';
import 'package:slide_panel/slide_panel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        // body: TransformTest(),
        appBar: AppBar(
          title: Text("Slide Panel"),
        ),
        body: SlidePanel(
          slideHandlerWidth: 10,
          slidePanelHeight: 300,
          slidePanelWidth: 280,
          slideOffBodyTap: true,
          leftPanelVisible: true,
          rightPanelVisible: true,
          body: Container(
            color: Colors.white,
          ),
          leftSlide: Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Left Panel",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 100,
                    height: 30,
                    child: RaisedButton(
                      onPressed: () => print("Transform1"),
                      child: Text("test!"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 100,
                    height: 30,
                    child: RaisedButton(
                      onPressed: () => print("Transform1"),
                      child: Text("test!"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 100,
                    height: 30,
                    child: RaisedButton(
                      onPressed: () => print("Transform1"),
                      child: Text("test!"),
                    ),
                  ),
                ),
              ],
            ),
          ),
          rightSlide: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Right Panel",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 100,
                  height: 30,
                  child: RaisedButton(
                    onPressed: () => print("Transform1"),
                    child: Text("test!"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 100,
                  height: 30,
                  child: RaisedButton(
                    onPressed: () => print("Transform1"),
                    child: Text("test!"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 100,
                  height: 30,
                  child: RaisedButton(
                    onPressed: () => print("Transform1"),
                    child: Text("test!"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
