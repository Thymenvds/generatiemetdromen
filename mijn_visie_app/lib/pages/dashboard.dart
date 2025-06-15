import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  final Widget drawer;

  const DashboardPage(this.drawer, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer,
      appBar: AppBar(
          title: const Text("Mijn Visie"),
          // actions: <Widget>[],
        ),
      body: Text("Dashboard"),
    );
  }
}