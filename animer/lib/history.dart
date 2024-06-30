import 'package:animer/history_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection("room").get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text("待機中...");
        }
        for (var room in snapshot.data!.docs) {
          print(room);
        }
        return Scaffold(
          appBar: AppBar(),
          body: ListView.builder(
            itemBuilder: (context, index) {
              var data = snapshot.data!.docs[index];
              Timestamp ts = data["atTime"];
              DateTime dts = ts.toDate();
              String fDate = DateFormat("yyyy/MM/dd").format(dts);
              return ListTile(
                leading: Icon(Icons.description),
                title: Text(
                    "${data["result"]["title"]}(${data["result"]["user"]})"),
                subtitle: Text(fDate),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return HistoryDetailPage(
                          data: data,
                        );
                      },
                    ),
                  );
                },
              );
            },
            itemCount: snapshot.data!.docs.length,
          ),
        );
      },
    );
  }
}
