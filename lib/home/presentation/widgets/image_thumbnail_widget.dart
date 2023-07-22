import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location_app/home/data/data_sources/local_data.dart';
import 'package:location_app/home/presentation/providers/gallery_provider.dart';
import 'package:photo_manager/photo_manager.dart';

Future<Widget> imageThumbnailWidget(AssetEntity asset, WidgetRef ref) async {
  final thumbData = await asset.thumbnailData;
  if (thumbData != null) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Image.memory(
              thumbData,
              fit: BoxFit.cover,
            ),
          ref.watch(getLocationProvider(asset.id)).when(
                  data: (value) {
                    // return ElevatedButton(onPressed: () async {
                    //   //await LocalData().getCityDataFromImage(asset.id, prevAsset.id);
                    // }, child: Text("Press"));
                    return Text("${value.locationData.split(",")[0]}, ${value.locationData.split(",")[1]}");
                  },
                  error: (error, stacktrace) {
                    print(error.toString());
                    return AlertDialog(
                              title: Text(error.toString()),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      //Navigator.pop(context);
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
  } else {
    return Container();
  }
}