import 'package:animer/main/main_controller.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TextEditingController _controller = TextEditingController();

  var _formKey = GlobalKey<FormState>();
  MainController ctrl = MainController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("何見る問題"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              '何見る問題',
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: Form(
                key: _formKey,
                child: TextFormField(
                  controller: _controller,
                  decoration: InputDecoration(
                    icon: Icon(Icons.person),
                    labelText: 'ユーザー名',
                    hintText: 'Enter your username',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ユーザー名を入力してください';
                    }
                    return null;
                  },
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                ctrl.onPressStart();
              },
              child: Text(
                "開始",
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  ctrl.onPressHistory();
                },
                child: Text("履歴"))
          ],
        ),
      ),
    );
  }
}
