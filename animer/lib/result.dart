import 'package:flutter/material.dart';

class ResultPage extends StatefulWidget {
  final String? title;
  final String? user;
  const ResultPage({super.key, this.title, this.user});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("見るアニメは..." + (widget.title ?? "")),
            Text("投稿者:${widget.user}")
          ],
        ),
      ),
    );
  }
}
