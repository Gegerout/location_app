import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location_app/home/data/data_sources/local_data.dart';
import 'package:location_app/home/data/models/image_model.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../data/repository/data_repository.dart';

final galleryProvider = FutureProvider((ref) async {
   final data = await DataRepository().getImagesFromGallery();
   return data.images;
});

final getLocationProvider = FutureProvider.family<ImageModel, String>((ref, id) async {
   final data = await LocalData().getCityDataFromImage(id);
   return data;
});