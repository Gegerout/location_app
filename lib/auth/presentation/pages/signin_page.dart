import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location_app/auth/presentation/pages/add_instagram_page.dart';
import 'package:location_app/auth/presentation/providers/signin_provider.dart';
import 'package:location_app/auth/presentation/providers/signup_provider.dart';
import 'package:location_app/home/presentation/pages/home_page.dart';

class SigninPage extends ConsumerWidget {
  SigninPage({Key? key}) : super(key: key);

  final TextEditingController emailCont = TextEditingController();
  final TextEditingController passwordCont = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign in"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[300]),
              child: TextFormField(
                controller: emailCont,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(left: 14),
                  hintText: "Email",
                  hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[300]),
              child: TextFormField(
                controller: passwordCont,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(left: 14),
                  hintText: "Password",
                  hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                  onPressed: () {
                    ref
                        .read(signinProvider.notifier)
                        .signinToAccount(emailCont.text, passwordCont.text)
                        .then((value) {
                      if (value != null) {
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => OtpVerificationPage(email: emailCont.text)));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    HomePage(userModel: value,)));
                      }
                      else {
                        showDialog(context: context, builder: (context) => AlertDialog(
                          title: const Text("Wrong credentials"),
                          actions: [
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Ok"))
                          ],
                        ));
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: const Text("Sign in",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white))),
            ),
          ],
        ),
      ),
    );
  }
}
