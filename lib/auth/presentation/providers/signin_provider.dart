import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location_app/auth/data/repository/data_repository.dart';

import '../../data/models/user_model.dart';

final signinProvider = ChangeNotifierProvider((ref) => signinNotifier());

class signinNotifier extends ChangeNotifier {
  Future<void> signinWithInstagram() async {
    await DataRepository().signinWithInstagram();
  }
}