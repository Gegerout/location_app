import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location_app/auth/data/repository/data_repository.dart';

import '../../data/models/user_model.dart';

final signinProvider = ChangeNotifierProvider((ref) => SigninNotifier());

class SigninNotifier extends ChangeNotifier {
  Future<UserModel?> signinToAccount(String email, String password) async {
    final data = await DataRepository().signinToAccount(email, password);
    if(data != null) {
      return data.data;
    }
    return null;
  }
}