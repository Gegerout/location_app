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
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
                onPressed: () {
                  ref.read(signupProvider.notifier).addInstagramAccount();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const LoadingPage()));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: const Text("Add Instagram Account",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white))),
          ),
        ),
      ),
    );
  }
}
