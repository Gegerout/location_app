import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location_app/auth/data/repository/data_repository.dart';

import '../../data/models/user_model.dart';

final signupProvider = ChangeNotifierProvider((ref) => SignupNotifier());

class SignupNotifier extends ChangeNotifier {
  Future<void> addInstagramAccount() async {
    await DataRepository().addInstagramAccount();
  }

  Future<bool> createUserAccount(String email, String password) async {
    final data = await DataRepository().createUserAccount(email, password);
    return data;
  }

  Future<bool> checkOtpCode(String email, String code) async {
    final data = await DataRepository().checkOtpCode(email, code);
    return data;
  }
}