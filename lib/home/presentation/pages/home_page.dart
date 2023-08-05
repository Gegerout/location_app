import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.accessToken}) : super(key: key);

  final String accessToken;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(accessToken),
    );
  }
}
