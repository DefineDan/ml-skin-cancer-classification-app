import 'package:flutter/material.dart';
import 'classify.dart';

showAlertDialog(BuildContext context) {
  // button setup
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      // pop alert
      Navigator.of(context).pop();
      // push image picker widget
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Pick()),
      );
    },
  );

  // AlertDialog setup
  AlertDialog alert = AlertDialog(
    title: Text("Warning"),
    content: Text(
      "This application does not replace examination by a doctor. It should only be used supplementary to detect dangerous lesions easier and faster.\n\nAt this point the diagnosis from the app is around 85% accurate. In doubt of the diagnosis of the app, please consult your doctor.",
      textAlign: TextAlign.justify,
    ),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
