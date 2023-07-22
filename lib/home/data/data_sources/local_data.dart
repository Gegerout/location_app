import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:location_app/home/data/models/image_model.dart';
import 'package:location_app/home/data/models/images_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';

class LocalData {
  Future<LatLng> getLocationDataFromImage(String id) async {
    if (await Permission.photos.isDenied) {
      await Permission.photos.request();
    }
    final status = await Permission.photos.status;

    if (status.isGranted) {
      final albums = await PhotoManager.getAssetPathList(
        type: RequestType.image,
        onlyAll: true,
      );

      final images = await albums[0].getAssetListRange(start: 0, end: 1000000);
      final file = images.where((element) => element.id == id).first;
      return file.latlngAsync();
    } else {
      throw Error();
    }
  }

  Future<ImagesModel> getImagesFromGallery() async {
    if (await Permission.photos.isDenied) {
      await Permission.photos.request();
    }
    final status = await Permission.photos.status;

    if (status.isGranted) {
      final albums = await PhotoManager.getAssetPathList(
        type: RequestType.image,
        onlyAll: true,
      );

      final images = await albums[0].getAssetListRange(start: 0, end: 1000000);
      final models = ImagesModel(images);
      return models;
    } else {
      throw Error();
    }
  }

  Future<ImageModel> getCityDataFromImage(String id) async {
    var dir = await getTemporaryDirectory();
    final File imageLocationData = File("${dir.path}/imagesLocationData.json");
    const apiUrl =
        "http://evgeniymuravyov.pythonanywhere.com/getLocation";
    final Dio dio = Dio();

    final latLongData = await getLocationDataFromImage(id);
    final res = await dio.get(apiUrl, queryParameters: {
      "longitude": latLongData.longitude,
      "latitude": latLongData.latitude,
    });

    final model = ImageModel(id, latLongData.longitude!, latLongData.latitude!, res.data);
    return model;
  }
}
