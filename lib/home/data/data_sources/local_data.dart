import 'dart:convert';
import 'dart:io';

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
}