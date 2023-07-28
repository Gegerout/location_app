import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location_app/home/presentation/providers/gallery_provider.dart';
import 'package:location_app/home/presentation/widgets/image_thumbnail_widget.dart';
import 'package:provider/provider.dart';

import '../../data/data_sources/local_data.dart';

class GalleryPage extends ConsumerWidget {
  const GalleryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imagesProvider = context.read<LocalData>();

    return Scaffold(
        appBar: AppBar(
          title: const Text("Gallery"),
        ),
        body: StreamBuilder(
          stream: imagesProvider.getImagesFromGallery(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                ),
                itemCount: snapshot.data!.images.length,
                itemBuilder: (BuildContext context, int index) {
                  return imageThumbnailWidget(
                      snapshot.data!.images[index],
                      snapshot.data!.thumbnailData[index],
                      snapshot.data!.imageData[index].locationData,
                      ref);
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:location_app/home/presentation/providers/gallery_provider.dart';
// import 'package:location_app/home/presentation/widgets/image_thumbnail_widget.dart';
//
// class GalleryPage extends ConsumerWidget {
//   const GalleryPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Gallery"),
//       ),
//         body: ref.watch(getAllDataProvider).when(
//             data: (value) {
//               return GridView.builder(
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 3,
//                   crossAxisSpacing: 4.0,
//                   mainAxisSpacing: 4.0,
//                 ),
//                 itemCount: value.images.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return imageThumbnailWidget(value.images[index], value.thumbnailData[index], value.imageData[index].locationData, ref);
//                 },
//               );
//             },
//             error: (error, stacktrace) {
//               return AlertDialog(
//                 title: Text(error.toString()),
//                 actions: [
//                   ElevatedButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       child: const Text("Ok"))
//                 ],
//               );
//             },
//             loading: () => const Center(
//                   child: CircularProgressIndicator(),
//                 )));
//   }
// }
