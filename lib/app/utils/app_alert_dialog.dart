import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';

class AppAlertDialog {
  void showSnackBar({BuildContext context, String text}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  ProgressDialog progressDialog({BuildContext context, String text}) {
    return ProgressDialog(context,
        message: Text(text, style: TextStyle(color: Color(0xff284d64))),
        dialogStyle: DialogStyle(borderRadius: BorderRadius.circular(15.0)),
        title: null);
  }

  AlertDialog backPressedAlert({BuildContext context, String text, dynamic screenName}) {
    return new AlertDialog(
      backgroundColor: Color(0xff315fd6),
      elevation: 5,
      content: new Text(text),
      actions: <Widget>[
        new GestureDetector(
          onTap: () => Navigator.of(context, rootNavigator: true).pop(),
          child: Text(
            "NO",
            style: TextStyle(color: Colors.white),
          ),
        ),
        SizedBox(
          width: 15,
        ),
        new GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => screenName)),
            child: Text("YES", style: TextStyle(color: Colors.white))),
        SizedBox(height: 16),
      ],
    );
  }
}
