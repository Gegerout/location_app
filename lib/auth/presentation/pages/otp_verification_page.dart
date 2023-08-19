import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location_app/auth/presentation/providers/signup_provider.dart';
import 'package:pinput/pinput.dart';

class OtpVerificationPage extends ConsumerWidget {
  OtpVerificationPage({Key? key, required this.email}) : super(key: key);

  final String email;
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Code verification"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 40),
          SizedBox(
            height: 64,
            child: ListView(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                const SizedBox(
                  width: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Pinput(
                    length: 6,
                    controller: controller,
                    defaultPinTheme: PinTheme(
                        textStyle: const TextStyle(fontSize: 14),
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                        ),
                        margin: const EdgeInsets.only(right: 26)),
                    submittedPinTheme: PinTheme(
                        textStyle: const TextStyle(fontSize: 14),
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color:
                              ref
                                  .watch(signupProvider)
                                  .isValidCode != null
                                  ? ref
                                  .watch(signupProvider)
                                  .isValidCode!
                                  ? Colors.blue
                                  : Colors.redAccent
                                  : Colors.blue),
                        ),
                        margin: const EdgeInsets.only(right: 26)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                  onPressed: () {
                    ref
                        .read(signupProvider.notifier)
                        .checkOtpCode(email, controller.text);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: const Text("Submit code",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white))),
            ),
          ),
        ],
      ),
    );
  }
}
