import 'dart:math';

import 'package:animer/result.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class RoomPage extends StatefulWidget {
  final String roomName;
  final String userName;
  const RoomPage({super.key, required this.roomName, required this.userName});

  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("room")
          .doc(widget.roomName)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text("読み込み中...もうちょっと待ってね❤");
        } else if (snapshot.data?.get("result") != "") {
          return ResultPage(title: snapshot.data?.get("result").toString());
          // Navigator.of(context).push(
          //   MaterialPageRoute(builder: (context) {
          //     return ResultPage();
          //   }),
          // );
        }
        var titles = snapshot.data?.get("titles");
        return Scaffold(
          body: Center(
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(Icons.person),
                        title: Text(titles[index]["title"]),
                        subtitle: Text(titles[index]["user"]),
                      );
                    },
                    itemCount: titles.length,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: TextFormField(
                    controller: _controller,
                    onFieldSubmitted: (value) {
                      animeSubmit();
                    },
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () {
                          animeSubmit();
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                ElevatedButton(
                  onPressed: () async {
                    await FirebaseFirestore.instance
                        .collection("room")
                        .doc(widget.roomName)
                        .update(
                      {
                        "result": titles[Random().nextInt(titles.length)]
                            ["title"]
                      },
                    );
                  },
                  child: Text("スタート！"),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void animeSubmit() async {
    await FirebaseFirestore.instance
        .collection("room")
        .doc(widget.roomName)
        .update(
      {
        "titles": FieldValue.arrayUnion(
          [
            {"title": _controller.text, "user": widget.userName}
          ],
        )
      },
    );
    _controller.clear();
  }
}
