import 'package:flutter/material.dart';
import 'package:location_app/auth/presentation/pages/create_account_page.dart';
import 'package:location_app/auth/presentation/pages/signin_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFEDE7),
      body: Column(
          children: [
            SizedBox(
              height: 370,
              width: double.infinity,
              child: Image.asset(
                "assets/images/welcome_top.png",
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 120),
            Padding(
              padding: const EdgeInsets.only(left: 36, right: 36),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Let's Get\nStarted", style: TextStyle(fontSize: 64,
                      fontFamily: "Futura BT",
                      height: 1,
                      fontWeight: FontWeight.w900,
                      color: Colors.black),),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CreateAccountPage()));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFF6930),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        child: const Text("Create account",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white))),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => SigninPage()));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF80261),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        child: const Text("Sign in",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white))),
                  ),
                ],
              ),
            )
          ],
        ),
    );
  }
}
