import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/user_model.dart';

class LocalData {
  Future<UserModel?> getUserDataFromStorage() async {
    var dir = await getTemporaryDirectory();
    final userDataFile = File("${dir.path}/userData.json");

    if(userDataFile.existsSync()) {
      final jsonData = json.decode(userDataFile.readAsStringSync());
      final userModel = UserModel.fromJson(jsonData);
      return userModel;
    }
    return null;
  }

  Future<void> writeUserDataToStorage(UserModel userModel) async {
    var dir = await getTemporaryDirectory();
    final userDataFile = File("${dir.path}/userData.json");

    userDataFile.writeAsStringSync(json.encode(userModel));
  }
}