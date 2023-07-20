import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location_app/home/presentation/providers/gallery_provider.dart';
import 'package:location_app/home/presentation/widgets/image_thumbnail_widget.dart';

class GalleryPage extends ConsumerWidget {
  const GalleryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gallery"),
      ),
        body: ref.watch(galleryProvider).when(
            data: (value) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                ),
                itemCount: value.images.length,
                itemBuilder: (BuildContext context, int index) {
                  return FutureBuilder<Widget>(
                    future: imageThumbnailWidget(value.images[index]),
                    builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.hasData) {
                        return snapshot.data!;
                      } else {
                        return Container(); // Placeholder or loading indicator
                      }
                    },
                  );
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
                )));
  }
}
