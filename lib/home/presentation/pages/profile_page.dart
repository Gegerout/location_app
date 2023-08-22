import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
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
        title: Text(userModel.username),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: SizedBox(
                    width: 100,
                    height: 100,
                    child: CachedNetworkImage(
                        imageUrl: userModel.profilePicture))),
            const SizedBox(height: 20),
            ref.watch(getPostsDataProvider(userModel.accessToken)).when(
                data: (value) {
                  if (value != null) {
                    if (value.$1?.imagesData != null) {
                      return GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4),
                          itemCount: value.$1!.imagesData!.data.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                showImageViewer(
                                    context,
                                    CachedNetworkImageProvider(
                                      value
                                          .$1!.imagesData!.data[index].mediaUrl,
                                    ));
                              },
                              child: SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: CachedNetworkImage(
                                    imageUrl: value
                                        .$1!.imagesData!.data[index].mediaUrl,
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
                                    errorWidget: (context, url, error) =>
                                        const Icon(
                                      Icons.error,
                                      color: Colors.redAccent,
                                    ),
                                  )),
                            );
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
      ),
    );
  }
}
