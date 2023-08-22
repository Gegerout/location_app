import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location_app/auth/presentation/pages/loading_page.dart';
import 'package:location_app/auth/presentation/providers/signup_provider.dart';

class AddInstagramPage extends ConsumerWidget {
  const AddInstagramPage(this.email, {Key? key}) : super(key: key);

  final String email;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        backgroundColor: const Color(0xFFFFEDE7),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                width: double.infinity,
                child: Image.asset(
                  "assets/images/add_inst_top.png",
                  scale: 4,
                  fit: BoxFit.cover,
                )),
            Padding(
              padding: const EdgeInsets.only(left: 36, right: 36, top: 80),
              child: Column(
                children: [
                  const Text("Add Instagram\nAccount", style: TextStyle(fontSize: 64,
                      fontFamily: "Futura BT",
                      height: 1,
                      fontWeight: FontWeight.w900,
                      color: Colors.black),),
                  const SizedBox(height: 80),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                        onPressed: () {
                          ref.read(signupProvider.notifier).addInstagramAccount();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoadingPage(email)));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF80261),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        child: const Text("Add account",
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontFamily: "Futura BT",
                                fontSize: 22,
                                color: Colors.white))),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
