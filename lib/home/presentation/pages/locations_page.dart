import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/data/models/user_model.dart';
import '../providers/get_posts_data.dart';

class LocationsPage extends ConsumerWidget {
  const LocationsPage({Key? key, required this.userModel}) : super(key: key);

  final UserModel userModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Locations page"),
      ),
      body: ref.watch(getPostsDataProvider(userModel.accessToken)).when(
          data: (value) {
            if (value != null) {
              if (value.locationData != null) {
                List cities = [];
                List countries = [];

                for (var element in value.locationData!.data) {
                  final location = element.loadedLocation.split(",");
                  if (location.length >= 2) {
                    if (!cities.contains(location[1])) {
                      cities.add(location[1]);
                      countries.add(location[0]);
                    }
                  } else {
                    cities.add(location[0]);
                    countries.add("");
                  }
                }

                return ListView.builder(
                  itemCount: cities.length,
                  itemBuilder: (context, index) {
                    return Text("${cities[index]}, ${countries[index]}",
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600));
                  },
                );
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
              )),
    );
  }
}
