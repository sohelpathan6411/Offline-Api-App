import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
var bearerToken = "786785e9-1b74-430a-80d9-aae49678954f";


void commonLaunchURL(_url) async =>
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';


pushReplacement(BuildContext context, Widget destination) {
  Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (c, a1, a2) => destination,
        transitionsBuilder: (c, anim, a2, child) =>
            FadeTransition(opacity: anim, child: child),
        transitionDuration: Duration(milliseconds: 300),
      ));
}

push(BuildContext context, Widget destination) {
  Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (c, a1, a2) => destination,
        transitionsBuilder: (c, anim, a2, child) =>
            FadeTransition(opacity: anim, child: child),
        transitionDuration: Duration(milliseconds: 300),
      ));
}

pop(BuildContext context) {
  Navigator.pop(context);
}

void commonToast(BuildContext context, String msg) {
  Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG,
      msg: msg, backgroundColor: Colors.black, textColor: Colors.white);
}



void logLongString(String s) {
  if (s == null || s.length <= 0) return;
  const int n = 1000;
  int startIndex = 0;
  int endIndex = n;
  while (startIndex < s.length) {
    if (endIndex > s.length) endIndex = s.length;
    print(s.substring(startIndex, endIndex));
    startIndex += n;
    endIndex = startIndex + n;
  }
}

