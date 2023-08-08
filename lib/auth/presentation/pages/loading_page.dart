import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location_app/auth/presentation/providers/signup_provider.dart';
import 'package:location_app/home/presentation/pages/home_page.dart';
import 'package:receive_intent/receive_intent.dart';
import 'package:uni_links/uni_links.dart';

class LoadingPage extends ConsumerStatefulWidget {
  const LoadingPage(this.email, {Key? key}) : super(key: key);

  final String email;

  @override
  ConsumerState<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends ConsumerState<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: linkStream,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            final url = Uri.parse(snapshot.data!);
            var accessToken = url.queryParameters["access_token"];
            var userId = url.queryParameters["user_id"];
            if (accessToken != null && userId != null) {
              ref
                  .read(signupProvider.notifier)
                  .getUserInstagramData(
                      accessToken, int.parse(userId), widget.email)
                  .then((value) {
                if (value != null) {
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                HomePage(accessToken: value.accessToken)),
                        (route) => false);
                  });
                } else {
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    Navigator.pop(context);
                  });
                }
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
