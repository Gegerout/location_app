import 'dart:typed_data';

import 'package:photo_manager/photo_manager.dart';

class ImagesModel {
  final List<AssetEntity> images;
  final List<Uint8List?> thumbnailData;

  ImagesModel(this.images, this.thumbnailData);
}