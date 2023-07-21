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
    const String apiKey = String.fromEnvironment("MAPS_API_KEY");
    final latLongData = await getLocationDataFromImage(id);
    if (imageLocationData.existsSync()) {
      final List data = await json.decode(imageLocationData.readAsStringSync());
      print(data.last);
      final prevLatLongData =
          LatLng(latitude: data.last["latitude"], longitude: data.last["longitude"]);

      if (prevLatLongData.latitude! - latLongData.latitude! < 0.001 &&
          prevLatLongData.longitude! - latLongData.longitude! < 0.001) {
        final List<dynamic> decoded =
            await json.decode(imageLocationData.readAsStringSync());
        print("Loaded from storage");
        return decoded.last;
      }
    }
    final Dio dio = Dio();
    final String apiUrl =
        "https://geocode-maps.yandex.ru/1.x/?apikey=$apiKey&geocode=${latLongData.longitude},${latLongData.latitude}&format=json";
    final res = await dio.get(apiUrl);
    List<dynamic> data = [];
    if (imageLocationData.existsSync()) {
      data = await json.decode(imageLocationData.readAsStringSync());
    }
    final model =
        ImageModel(id, latLongData.longitude!, latLongData.latitude!, {
      "country": res.data["response"]?["GeoObjectCollection"]?["featureMember"]
              [0]?["GeoObject"]?["metaDataProperty"]?["GeocoderMetaData"]
          ?["Address"]?["Components"][0]?["name"],
      "city": res.data["response"]?["GeoObjectCollection"]?["featureMember"][0]
              ?["GeoObject"]?["metaDataProperty"]?["GeocoderMetaData"]
          ?["Address"]?["Components"][2]?["name"]
    });
    print("Loaded from remote storage");
    data.add(model);
    final encoded = json.encode(data);
    imageLocationData.writeAsStringSync(encoded);
    return model;
  }
}
