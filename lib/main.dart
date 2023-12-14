import 'package:flutter/material.dart';
import 'package:traktstats/screens/homescreen.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Homescreen()
      )
    )
  );
}