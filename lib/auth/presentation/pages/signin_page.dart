import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location_app/auth/presentation/providers/signin_provider.dart';

class SigninPage extends ConsumerWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            ref.read(signinProvider).signinWithInstagram();
          },
          child: Text("Signin",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        ),
      ),
    );
  }
}
