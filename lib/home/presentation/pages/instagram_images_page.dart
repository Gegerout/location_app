import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location_app/home/presentation/providers/gallery_provider.dart';

class InstagramImagesPage extends ConsumerWidget {
  const InstagramImagesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("instagram Images Page"),
      ),
      body: ref.watch(getLocationsProvider).when(
              data: (value) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return Text(value[index]);
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
