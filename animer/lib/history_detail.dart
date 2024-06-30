import 'package:flutter/material.dart';

class HistoryDetailPage extends StatefulWidget {
  final data;
  const HistoryDetailPage({super.key, required this.data});

  @override
  State<HistoryDetailPage> createState() => _HistoryDetailPageState();
}

class _HistoryDetailPageState extends State<HistoryDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemBuilder: (context, index) {
          bool isAnswer = widget.data["titles"][index]["title"] ==
              widget.data["result"]["title"];
          return ListTile(
            leading: isAnswer ? Icon(Icons.star) : Icon(Icons.person),
            title: Text(widget.data["titles"][index]["title"]),
            subtitle: Text(widget.data["titles"][index]["user"]),
          );
        },
        itemCount: widget.data["titles"].length,
      ),
    );
  }
}
