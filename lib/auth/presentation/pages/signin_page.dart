import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location_app/auth/presentation/pages/create_account_page.dart';
import 'package:location_app/auth/presentation/providers/signin_provider.dart';
import 'package:location_app/home/presentation/pages/home_page.dart';

class SigninPage extends ConsumerWidget {
  SigninPage({Key? key}) : super(key: key);

  final TextEditingController emailCont = TextEditingController();
  final TextEditingController passwordCont = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 400,
              child: Stack(
                children: [
                  SizedBox(
                      width: double.infinity,
                      child: Image.asset(
                        "assets/images/signin_top.png",
                        scale: 4,
                        fit: BoxFit.cover,
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 46, left: 8),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          size: 28,
                          color: Colors.white,
                        )),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 36, bottom: 134),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Welcome\nBack",
                        style: TextStyle(
                            fontSize: 46,
                            fontFamily: "Futura BT",
                            fontWeight: FontWeight.w900,
                            color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.only(left: 36, right: 36),
              child: Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    border: Border.all(color: Colors.black)),
                child: Center(
                  child: TextFormField(
                    controller: emailCont,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(
                        fontSize: 18,
                        fontFamily: "Futura BT",
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 30),
                      hintText: "Email",
                      hintStyle: TextStyle(
                          fontSize: 18,
                          fontFamily: "Futura BT",
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 36, right: 36),
              child: Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    border: Border.all(color: Colors.black)),
                child: Center(
                  child: TextFormField(
                    controller: passwordCont,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    style: const TextStyle(
                        fontSize: 18,
                        fontFamily: "Futura BT",
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 30),
                      hintText: "Password",
                      hintStyle: TextStyle(
                          fontSize: 18,
                          fontFamily: "Futura BT",
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 43),
            Padding(
              padding: const EdgeInsets.only(left: 36, right: 36),
              child: Row(
                children: [
                  const Text(
                    "Sign In",
                    style: TextStyle(
                        fontSize: 32,
                        fontFamily: "Futura BT",
                        fontWeight: FontWeight.w900,
                        color: Colors.black),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 64,
                    height: 64,
                    child: ElevatedButton(
                      onPressed: () {
                        ref.read(signinProvider.notifier).changeLoading(true);
                        ref
                            .read(signinProvider.notifier)
                            .signinToAccount(emailCont.text, passwordCont.text)
                            .then((value) {
                          if (value != null) {
                            //Navigator.push(context, MaterialPageRoute(builder: (context) => OtpVerificationPage(email: emailCont.text)));
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage(
                                          userModel: value,
                                        )),
                                (route) => false);
                          } else {
                            ref.read(signinProvider.notifier).changeLoading(false);
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
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
                        padding: EdgeInsets.zero,
                          backgroundColor: const Color(0xFFFF6930),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40))),
                      child: ref.watch(signinProvider).isLoading
                          ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ))
                          : Image.asset(
                        "assets/images/auth_arrow.png",
                        scale: 4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100, left: 36, right: 36),
              child: Row(
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: Container(
                          width: 78,
                          height: 9,
                          decoration: BoxDecoration(
                              color: const Color(0xFFFF6930).withOpacity(0.52)),
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CreateAccountPage()));
                          },
                          style: TextButton.styleFrom(
                              padding: const EdgeInsets.only(left: 6)),
                          child: const Text(
                            "Sign Up ",
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontFamily: "Futura BT",
                                fontSize: 18,
                                color: Colors.black),
                          )),
                    ],
                  ),
                  const Spacer(),
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: Container(
                          width: 153,
                          height: 9,
                          decoration: BoxDecoration(
                              color: const Color(0xFFFF0000).withOpacity(0.75)),
                        ),
                      ),
                      SizedBox(
                        width: 147,
                        child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                                padding: const EdgeInsets.only(left: 9)),
                            child: const Text(
                              "Forgot Password",
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontFamily: "Futura BT",
                                  fontSize: 18,
                                  color: Colors.black),
                            )),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
