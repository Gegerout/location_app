import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location_app/home/data/data_sources/local_data.dart';
import 'package:location_app/home/data/models/image_model.dart';
import 'package:location_app/home/data/models/images_model.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../data/repository/data_repository.dart';

// final galleryProvider = FutureProvider((ref) async {
//    if (await Permission.photos.isDenied) {
//       await Permission.photos.request();
//    }
//    if (await Permission.accessMediaLocation.isDenied) {
//       await Permission.accessMediaLocation.request();
//    }
//    final data = await DataRepository().getImagesFromGallery();
//    return data.images;
// });

final getLocationProvider =
    FutureProvider.family<ImageModel, String>((ref, id) async {
  final data = await LocalData().getCityDataFromImage(id);
  return data.$1;
});

final getAllDataProvider = FutureProvider((ref) {
  return LocalData().getImagesFromGallery();
});

final getCitiesProvider = StreamProvider<ImagesModel>((ref) {
  return LocalData().getImagesFromGallery();
});

final getLocationsProvider = FutureProvider((ref) async {
   final data = await DataRepository().getLocations();
   return data;
});