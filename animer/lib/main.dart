import 'package:animer/firebase_options.dart';
import 'package:animer/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '何見る問題',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: '何見る問題'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _controller = TextEditingController();

  bool isWaiting = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              '何見る問題',
            ),
            TextField(
              controller: _controller,
            ),
            ElevatedButton(
              onPressed: () async {
                if (isWaiting) return;
                isWaiting = true;
                String docName = "";
                var docs =
                    await FirebaseFirestore.instance.collection("room").get();
                for (var doc in docs.docs) {
                  if (doc.data()["result"] == "") {
                    docName = doc.id;
                    break;
                  }
                }
                if (docName == "") {
                  docName = Uuid().v1();
                  await FirebaseFirestore.instance
                      .collection("room")
                      .doc(docName)
                      .set({"result": "", "titles": []});
                }
                isWaiting = false;
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) {
                    return RoomPage(
                      roomName: docName,
                    );
                  }),
                );
              },
              child: Text(
                "ボタン",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
