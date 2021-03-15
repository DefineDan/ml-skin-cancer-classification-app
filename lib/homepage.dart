import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'alertdialog.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 40.0),
            Column(
              children: <Widget>[
                Image.asset(
                  'assets/logo.png',
                  height: 200,
                ),
                SizedBox(height: 60.0),
                Text(
                  'This app can diagnose pigmented skin lesions via machine learning by classifying your case in these 7 important categories.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 2, 20, 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.green, width: 1.5),
                      ),
                      child: Text(
                        'benign tumors',
                        textAlign: TextAlign.center,
                        style: TextStyle(),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 2, 20, 2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.red, width: 1.5)),
                      child: Text(
                        'malignant tumors',
                        textAlign: TextAlign.center,
                        style: TextStyle(),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10.0),
                new ListTile(
                  visualDensity: VisualDensity.compact,
                  dense: true,
                  horizontalTitleGap: 1,
                  leading: Icon(
                    Icons.fiber_manual_record,
                    color: Colors.green,
                  ),
                  title: new Text(
                    'melanocytic nevi',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                new ListTile(
                  visualDensity: VisualDensity.compact,
                  dense: true,
                  horizontalTitleGap: 1,
                  leading: Icon(
                    Icons.fiber_manual_record,
                    color: Colors.red,
                  ),
                  title: new Text(
                    'melanoma',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                new ListTile(
                  visualDensity: VisualDensity.compact,
                  dense: true,
                  horizontalTitleGap: 1,
                  leading: Icon(
                    Icons.fiber_manual_record,
                    color: Colors.green,
                  ),
                  title: new Text(
                    'benign keratosis-like lesions',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                new ListTile(
                  visualDensity: VisualDensity.compact,
                  dense: true,
                  horizontalTitleGap: 1,
                  leading: Icon(
                    Icons.fiber_manual_record,
                    color: Colors.red,
                  ),
                  title: new Text(
                    'basal cell carcinoma',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                new ListTile(
                  visualDensity: VisualDensity.compact,
                  dense: true,
                  horizontalTitleGap: 1,
                  leading: Icon(
                    Icons.fiber_manual_record,
                    color: Colors.red,
                  ),
                  title: new Text(
                    'Actinic keratoses / Bowen\'s disease',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                new ListTile(
                  visualDensity: VisualDensity.compact,
                  dense: true,
                  horizontalTitleGap: 1,
                  leading: Icon(
                    Icons.fiber_manual_record,
                    color: Colors.green,
                  ),
                  title: new Text(
                    'vascular lesions',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                new ListTile(
                  visualDensity: VisualDensity.compact,
                  dense: true,
                  horizontalTitleGap: 1,
                  leading: Icon(
                    Icons.fiber_manual_record,
                    color: Colors.green,
                  ),
                  title: new Text(
                    'dermatofibroma',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.black),
                child: Text('Check my Lesion'),
                onPressed: () {
                  showAlertDialog(context);
                })
          ],
        ),
      ),
    );
  }
}
