import 'package:flutter/material.dart';

class ResultPage extends StatefulWidget {
  final String? title;
  const ResultPage({super.key, this.title});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text("見るアニメは..." + (widget.title??"")),
      ),
    );
  }
}
