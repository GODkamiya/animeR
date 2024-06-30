import 'package:animer/main/main_model.dart';

class MainController {
  MainModel model = MainModel();
  void onPressStart() {
    model.joinRoom();
  }

  void onPressHistory() {
    model.goHistoryPage();
  }
}
