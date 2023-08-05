import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location_app/auth/data/repository/data_repository.dart';

final signinProvider = ChangeNotifierProvider((ref) => signinNotifier());

class signinNotifier extends ChangeNotifier {
  void signinWithInstagram() async {
    await DataRepository().signinWithInstagram();
  }
}