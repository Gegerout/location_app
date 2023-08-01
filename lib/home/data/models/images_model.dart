import 'dart:typed_data';

import 'package:photo_manager/photo_manager.dart';

import 'image_model.dart';

class ImagesModel {
  final List<AssetEntity> images;
  final List<Uint8List?> thumbnailData;
  final List<ImageModel> imageData;
  final List<dynamic> locationData;
  final List<dynamic> cities;

  ImagesModel(this.images, this.thumbnailData, this.imageData, this.locationData, this.cities);
}