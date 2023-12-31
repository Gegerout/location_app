import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location_app/auth/presentation/pages/add_instagram_page.dart';
import 'package:location_app/auth/presentation/pages/signin_page.dart';
import 'package:location_app/auth/presentation/providers/signup_provider.dart';

class CreateAccountPage extends ConsumerWidget {
  CreateAccountPage({Key? key}) : super(key: key);

  final TextEditingController emailCont = TextEditingController();
  final TextEditingController passwordCont = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          SizedBox(
            height: 320,
            child: Stack(
              children: [
                SizedBox(
                    width: double.infinity,
                    child: Image.asset(
                      "assets/images/signup_top.png",
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
                  padding: EdgeInsets.only(left: 36, bottom: 52),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "Create\nAccount",
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
          const SizedBox(height: 30),
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
                  "Sign Up",
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
                      ref.read(signupProvider.notifier).changeLoading(true);
                      ref
                          .read(signupProvider.notifier)
                          .createUserAccount(emailCont.text, passwordCont.text)
                          .then((value) {
                        if (value) {
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => OtpVerificationPage(email: emailCont.text)));
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AddInstagramPage(emailCont.text)));
                        } else {
                          ref.read(signupProvider.notifier).changeLoading(false);
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: const Text("Something went wrong"),
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
                    child: ref.watch(signupProvider).isLoading
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
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 36),
            child: Row(
              children: [
                SizedBox(
                    height: 200,
                    child: Image.asset(
                      "assets/images/signup_bottom.png",
                      scale: 4,
                      fit: BoxFit.cover,
                    )),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(top: 56),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: Container(
                          width: 70,
                          height: 9,
                          decoration: BoxDecoration(
                              color: const Color(0xFFFF6930).withOpacity(0.52)),
                        ),
                      ),
                      SizedBox(
                        width: 70,
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SigninPage()));
                            },
                            style: TextButton.styleFrom(
                                padding: const EdgeInsets.only(left: 6)),
                            child: const Text(
                              "Sign In ",
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontFamily: "Futura BT",
                                  fontSize: 18,
                                  color: Colors.black),
                            )),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
