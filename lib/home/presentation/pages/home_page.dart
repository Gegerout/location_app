import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location_app/home/presentation/providers/get_images_provider.dart';

import '../../../auth/data/models/user_model.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key, required this.userModel}) : super(key: key);

  final UserModel userModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home page"),
      ),
      body: Column(
        children: [
          Text(
            userModel.username,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
          ),
          ref.watch(getImagesFromProfileProvider(userModel.accessToken)).when(
              data: (value) {
                if (value != null) {
                  return GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4),
                      itemCount: value.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                            height: 100,
                            width: 100,
                            child: CachedNetworkImage(
                              imageUrl: value[index].mediaUrl,
                              fit: BoxFit.fill,
                            ));
                      });
                }
                return const Text("Something went wrong");
              },
              error: (error, stacktrace) {
                return AlertDialog(
                  title: Text(error.toString()),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Ok"))
                  ],
                );
              },
              loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ))
        ],
      ),
    );
  }
}
