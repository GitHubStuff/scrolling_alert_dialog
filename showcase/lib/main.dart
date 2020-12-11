import 'package:flutter/material.dart';
import 'package:scrolling_alert_dialog/scrolling_alert_dialog.dart';

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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool pushed = false;
  String string = '${DateTime.now().toLocal()}'; //\nOr Here\nNot THERE!\nOver there?\nThats the spot\nYou are kinky';

  Widget _scaffold() {
    // string += '\n1:' + string;
    // string += '\n2)' + string;
    // string += '\n3)' + string;
    // string += '\n4)' + string;
    // string += '\n5)' + string;
    // string += '\n6)' + string;
    // string += '\n7)' + string;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '${DateTime.now().toLocal()}',
              style: Theme.of(context).textTheme.headline6,
            ),
            Text('Have you pushed the button?', style: Theme.of(context).textTheme.headline5),
            Text(
              pushed ? '😈' : '😇',
              style: Theme.of(context).textTheme.headline3,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            pushed = !pushed;
          });
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => ScrollingAlertDialog(
              header: Text('HEADER!'),
              bodyWidget: Text(
                string,
                style: TextStyle(fontSize: 26.0),
              ),
              dismissButton: ScrollAlertButton(
                body: Text('Dismiss'),
                onTapCallback: () {
                  debugPrint('Dismiss');
                },
              ),
              buttons: buttons(),
            ),
          );
          string += "\n${DateTime.now().toLocal()}";
        },
        tooltip: 'Push',
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _scaffold();
  }

  List<ScrollAlertButton> buttons() {
    return [
      ScrollAlertButton(
        body: Text('Figures'),
        onTapCallback: () {
          debugPrint('Figures');
        },
      ),
      ScrollAlertButton(
        body: Text('Brup'),
        onTapCallback: () {
          debugPrint('Burp');
        },
      ),
      // ScrollAlertButton(
      //   tag: 'Dismiss',
      //   body: Text('Done!'),
      //   onTapFunction: (tag, response) {},
      //   response: null,
      // ),
      // ScrollAlertButton(
      //   tag: 'Cleo',
      //   body: Text('Cleo!'),
      //   onTapFunction: (tag, response) {},
      //   response: null,
      // ),
      // ScrollAlertButton(
      //   tag: 'Bob',
      //   body: Text('Fuck Bob!'),
      //   onTapFunction: (tag, response) {},
      //   response: null,
      // )
    ];
  }
}
