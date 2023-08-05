import 'package:flutter/material.dart';
import 'package:location_app/home/presentation/pages/home_page.dart';
import 'package:receive_intent/receive_intent.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: ReceiveIntent.receivedIntentStream,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            final url = Uri.parse(snapshot.data!.data!);
            var accessToken = url.queryParameters["access_token"];
            if (accessToken != null) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                    builder: (context) => HomePage(accessToken: accessToken)), (
                    route) => false);
              });
            } else {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                Navigator.pop(context);
              });
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
