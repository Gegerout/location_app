import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location_app/auth/data/repository/data_repository.dart';

import '../../data/models/user_model.dart';

final signupProvider = ChangeNotifierProvider((ref) => SignupNotifier());

class SignupNotifier extends ChangeNotifier {
  bool? isValidCode;
  bool isLoading = false;

  Future<void> addInstagramAccount() async {
    await DataRepository().addInstagramAccount();
  }

  Future<bool> createUserAccount(String email, String password) async {
    final data = await DataRepository().createUserAccount(email, password);
    return data;
  }

  Future<void> checkOtpCode(String email, String code) async {
    final data = await DataRepository().checkOtpCode(email, code);
    isValidCode = data;
    notifyListeners();
  }

  Future<UserModel?> getUserInstagramData(String accessToken, int userId, String email) async {
    final data = await DataRepository().getUserInstagramData(accessToken, userId, email);
    if(data != null) {
      return data.data;
    }
    return null;
  }

  void changeLoading(bool value) async {
    isLoading = value;
  }
}