import 'dart:convert';
import 'dart:io';

import 'package:location_app/home/data/models/image_location_model.dart';
import 'package:path_provider/path_provider.dart';

import '../models/posts_images_model.dart';

class LocalData {
  Future<List<PostsImagesModel>?> getImagesFromStorage() async {
    var dir = await getTemporaryDirectory();
    final imagesDataFile = File("${dir.path}/imagesData.json");

    if(imagesDataFile.existsSync()) {
      final data = json.decode(imagesDataFile.readAsStringSync());
      final models = (data as List).map((e) => PostsImagesModel.fromJson(e)).toList();
      return models;
    }
    return null;
  }

  Future<void> writeImagesToStorage(List<PostsImagesModel> models) async {
    var dir = await getTemporaryDirectory();
    final imagesDataFile = File("${dir.path}/imagesData.json");
    imagesDataFile.writeAsStringSync(json.encode(models));
  }

  Future<List<ImageLocationModel>?> getLocationsFromStorage() async {
    var dir = await getTemporaryDirectory();
    final locationsDataFile = File("${dir.path}/locationsData.json");

    if(locationsDataFile.existsSync()) {
      final data = json.decode(locationsDataFile.readAsStringSync());
      final models = (data as List).map((e) => ImageLocationModel.fromJson(e)).toList();
      return models;
    }
    return null;
  }

  Future<void> writeLocationsToStorage(List<ImageLocationModel> models) async {
    var dir = await getTemporaryDirectory();
    final locationsDataFile = File("${dir.path}/locationsData.json");
    locationsDataFile.writeAsStringSync(json.encode(models));
  }
}