import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location_app/home/presentation/providers/gallery_provider.dart';

class InstagramImagesPage extends ConsumerWidget {
  const InstagramImagesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Instagram Images Page"),
      ),
      body: ref.watch(getLocationsProvider).when(
          data: (value) {
            return Center(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: value.length,
                itemBuilder: (context, index) {
                  return Center(
                      child: Text(
                    value[index],
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.w500),
                  ));
                },
              ),
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
