import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location_app/auth/presentation/pages/loading_page.dart';
import 'package:location_app/auth/presentation/providers/signup_provider.dart';

class AddInstagramPage extends ConsumerWidget {
  const AddInstagramPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            ref.read(signupProvider.notifier).addInstagramAccount();
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LoadingPage()));
          },
          child: Text("Signin",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        ),
      ),
    );
  }
}
