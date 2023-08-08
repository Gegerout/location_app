import 'package:flutter/material.dart';

import '../../../auth/data/models/user_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.userModel}) : super(key: key);

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Text(userModel.username)),
    );
  }
}
