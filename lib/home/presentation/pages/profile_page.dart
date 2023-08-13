import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/data/models/user_model.dart';
import '../providers/get_posts_data.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({Key? key, required this.userModel}) : super(key: key);

  final UserModel userModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile page"),
      ),
      body: Column(
        children: [
          Text(
            userModel.username,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
          ),
          ref.watch(getPostsDataProvider(userModel.accessToken)).when(
              data: (value) {
                if (value != null) {
                  if(value.$1?.imagesData != null) {
                    return GridView.builder(
                        shrinkWrap: true,
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4),
                        itemCount: value.$1!.imagesData!.data.length,
                        itemBuilder: (context, index) {
                          return SizedBox(
                              height: 100,
                              width: 100,
                              child: CachedNetworkImage(
                                imageUrl: value.$1!.imagesData!.data[index].mediaUrl,
                                fit: BoxFit.cover,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                    Center(
                                      child: SizedBox(
                                        height: 40,
                                        width: 40,
                                        child: CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                      ),
                                    ),
                                errorWidget: (context, url, error) => const Icon(
                                  Icons.error,
                                  color: Colors.redAccent,
                                ),
                              ));
                        });
                  }
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
