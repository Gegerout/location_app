import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location_app/home/presentation/providers/get_images_provider.dart';

import '../../../auth/data/models/user_model.dart';

class LocationsPage extends ConsumerWidget {
  const LocationsPage({Key? key, required this.userModel}) : super(key: key);

  final UserModel userModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Locations page"),
      ),
      body: ref.watch(getImagesFromProfileProvider(userModel.accessToken)).when(
              data: (value) {
                return ListView.builder(
                  itemCount: value!.locationData!.data.length,
                  itemBuilder: (context, index) {
                    return Text(value!.locationData!.data[index].instagramLocation);
                  },
                );
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
              )),
    );
  }
}
