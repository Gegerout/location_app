import 'dart:typed_data';

import 'package:photo_manager/photo_manager.dart';

class ImageModel {
  final String id;
  final double longitude;
  final double latitude;
  final Uint8List? thumbnailData;
  final Map<String, dynamic> locationData;

  ImageModel(this.id, this.longitude, this.latitude, this.locationData, this.thumbnailData);

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(json["id"], json["latitude"], json["latitude"], json["locationData"], json["thumbnailData"]);
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "longitude": longitude,
    "latitude": latitude,
    "locationData": locationData,
    "thumbnailData": thumbnailData
  };
}