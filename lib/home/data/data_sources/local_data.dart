import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:location_app/home/data/models/image_model.dart';
import 'package:location_app/home/data/models/images_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_manager/photo_manager.dart';
import 'dart:math';

class LocalData extends ChangeNotifier {
  final double earthRadius = 6371.0;

  Future<LatLng> getLocationDataFromImage(String id) async {
    final albums = await PhotoManager.getAssetPathList(
      type: RequestType.image,
      onlyAll: true,
    );

    final images = await albums[0].getAssetListRange(start: 0, end: 1000000);
    final file = images.where((element) => element.id == id).first;
    return file.latlngAsync();
  }

  Stream<ImagesModel> getImagesFromGallery() async* {
    final albums = await PhotoManager.getAssetPathList(
      type: RequestType.image,
      onlyAll: true,
    );

    final images = await albums[0].getAssetListRange(start: 0, end: 1000000);
    final thumbnailData = await Future.wait(
        images.map((e) async => await e.thumbnailData).toList());
    List<ImageModel> imageData = [];
    List<dynamic> locationData = [];

    for(int i = 1; i < images.length; i++) {
      final data = await getCityDataFromImage(images[i-1].id);
      imageData.add(data.$1);
      locationData = data.$2;
      yield ImagesModel(images.sublist(0, i), thumbnailData, imageData, locationData);
    }

    // final models = ImagesModel(images, thumbnailData, imageData, locationData);
    // return models;
  }

  Future<(ImageModel, List<dynamic>)> getCityDataFromImage(String id) async {
    // var dir = await getTemporaryDirectory();
    // final File imageLocationData = File("${dir.path}/imagesLocationData.json");
    // const apiUrl = "http://evgeniymuravyov.pythonanywhere.com/getLocation";
    // final Dio dio = Dio();
    //
    // final latLongData = await getLocationDataFromImage(id);
    // final res = await dio.get(apiUrl, queryParameters: {
    //   "longitude": latLongData.longitude,
    //   "latitude": latLongData.latitude,
    // }, options: Options(receiveTimeout: const Duration(seconds: 60)));
    //
    // final model =
    //     ImageModel(id, latLongData.longitude!, latLongData.latitude!, res.data);
    // return model;
    const apiUrl = "https://geocode-maps.yandex.ru/1.x/";
    final Dio dio = Dio();
    var dir = await getTemporaryDirectory();
    final File imageLocationData = File("${dir.path}/imagesLocationData.json");
    List<dynamic> data = [];
    double lastLon = 0.0;
    double lastLat = 0.0;
    Map<String, dynamic> lastLocation = {
      "country": "",
      "city": ""
    };

    if (imageLocationData.existsSync()) {
      data = json.decode(imageLocationData.readAsStringSync());
      final latLongData = await getLocationDataFromImage(id);
      final coordinates = [];
      for (int i = 0; i < data.length; i++) {
        final coordinates = data[i]["coordinates"];
        final lastLoc = data[i]["location"];
        final avrCoordinates = calculateAverageCoordinates(coordinates);

        if (areCoordinatesClose(
            latLongData.latitude!, latLongData.longitude!, avrCoordinates[0],
            avrCoordinates[1], 3)) {
          lastLon = latLongData.longitude!;
          lastLat = latLongData.latitude!;
          final model = ImageModel(id, lastLon, lastLat, lastLoc);
          coordinates.add([latLongData.latitude!, latLongData.longitude!]);
          data[i]["coordinates"] = coordinates;
          imageLocationData.writeAsStringSync(json.encode(data));
          return (model, data);
        } else {
          continue;
        }
        //avrData.add(calculateAverageCoordinates(coordinates));
      }
      final res = await dio.get(apiUrl, queryParameters: {
        "apikey": "a4048f27-af7e-474c-af42-92cd0a03eccb",
        "geocode": "${latLongData.longitude},${latLongData.latitude}",
        "format": "json"
      });
      final List answer = res
          .data["response"]["GeoObjectCollection"]["featureMember"][0]["GeoObject"]["metaDataProperty"][
      "GeocoderMetaData"]["text"].split(",");
      lastLon = latLongData.longitude!;
      lastLat = latLongData.latitude!;
      if (answer.length >= 2) {
        lastLocation = {
          "country": answer[0],
          "city": answer[1]
        };
        final model = ImageModel(id, lastLon, lastLat, lastLocation);
        coordinates.add([latLongData.latitude!, latLongData.longitude!]);
        data.add({
          "coordinates": coordinates,
          "location": lastLocation
        });
        imageLocationData.writeAsStringSync(json.encode(data));
        return (model, data);
      } else {
        lastLocation = {
          "country": answer[0],
          "city": ""
        };
        final model = ImageModel(id, lastLon, lastLat, lastLocation);
        coordinates.add([latLongData.latitude!, latLongData.longitude!]);
        data.add({
          "coordinates": coordinates,
          "location": lastLocation
        });
        imageLocationData.writeAsStringSync(json.encode(data));
        return (model, data);
      }
      // lastLon = data.last["longitude"];
      // lastLat = data.last["latitude"];
      // lastLocation = data.last["locationData"];
    } else {
      final latLongData = await getLocationDataFromImage(id);
      final coordinates = [];

      final res = await dio.get(apiUrl, queryParameters: {
        "apikey": "a4048f27-af7e-474c-af42-92cd0a03eccb",
        "geocode": "${latLongData.longitude},${latLongData.latitude}",
        "format": "json"
      });
      final List answer = res
          .data["response"]["GeoObjectCollection"]["featureMember"][0]["GeoObject"]["metaDataProperty"][
      "GeocoderMetaData"]["text"].split(",");
      lastLon = latLongData.longitude!;
      lastLat = latLongData.latitude!;
      if (answer.length >= 2) {
        lastLocation = {
          "country": answer[0],
          "city": answer[1]
        };
        final model = ImageModel(id, lastLon, lastLat, lastLocation);
        coordinates.add([latLongData.latitude!, latLongData.longitude!]);
        data.add({
          "coordinates": coordinates,
          "location": lastLocation
        });
        imageLocationData.writeAsStringSync(json.encode(data));
        return (model, data);
      } else {
        lastLocation = {
          "country": answer[0],
          "city": ""
        };
        final model = ImageModel(id, lastLon, lastLat, lastLocation);
        coordinates.add([latLongData.latitude!, latLongData.longitude!]);
        data.add({
          "coordinates": coordinates,
          "location": lastLocation
        });
        imageLocationData.writeAsStringSync(json.encode(data));
        return (model, data);
      }

    // final latLongData = await getLocationDataFromImage(id);
    // if(areCoordinatesClose(latLongData.latitude!, latLongData.longitude!, lastLat, lastLon, 10)) {
    //   lastLon = latLongData.longitude!;
    //   lastLat = latLongData.latitude!;
    //   final model = ImageModel(id, lastLon, lastLat, lastLocation);
    //   data.add(model);
    //   imageLocationData.writeAsStringSync(json.encode(data));
    //   return model;
    // } else {
    //   final res = await dio.get(apiUrl, queryParameters: {
    //     "apikey": "a4048f27-af7e-474c-af42-92cd0a03eccb",
    //     "geocode": "${latLongData.longitude},${latLongData.latitude}",
    //     "format": "json"
    //   });
    //   final List answer = res.data["response"]["GeoObjectCollection"]["featureMember"][0]["GeoObject"]["metaDataProperty"][
    //   "GeocoderMetaData"]["text"].split(",");
    //   lastLon = latLongData.longitude!;
    //   lastLat = latLongData.latitude!;
    //   if(answer.length >= 2) {
    //     lastLocation = {
    //       "country": answer[0],
    //       "city": answer[1]
    //     };
    //     final model = ImageModel(id, lastLon, lastLat, lastLocation);
    //     data.add(model);
    //     imageLocationData.writeAsStringSync(json.encode(data));
    //     return model;
    //   } else {
    //     lastLocation = {
    //       "country": answer[0],
    //       "city": ""
    //     };
    //     final model = ImageModel(id, lastLon, lastLat, lastLocation);
    //     data.add(model);
    //     imageLocationData.writeAsStringSync(json.encode(data));
    //     return model;
    //   }
    }
  }
  
  double degreesToRadians(double degrees) {
    return degrees * pi / 180.0;
  }

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    double dLat = degreesToRadians(lat2 - lat1);
    double dLon = degreesToRadians(lon2 - lon1);

    double a = pow(sin(dLat / 2), 2) + cos(degreesToRadians(lat1)) * cos(degreesToRadians(lat2)) * pow(sin(dLon / 2), 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return earthRadius * c;
  }

  bool areCoordinatesClose(double lat1, double lon1, double lat2, double lon2, double thresholdDistance) {
    double distance = calculateDistance(lat1, lon1, lat2, lon2);
    return distance <= thresholdDistance;
  }

  List<double> calculateAverageCoordinates(List coordinates) {
    if (coordinates.isEmpty) {
      throw ArgumentError("List is empty");
    }

    double sumLatitude = 0;
    double sumLongitude = 0;

    for (List coordinate in coordinates) {
      sumLatitude += coordinate[0];
      sumLongitude += coordinate[1];
    }

    double averageLatitude = sumLatitude / coordinates.length;
    double averageLongitude = sumLongitude / coordinates.length;

    return [averageLatitude, averageLongitude];
  }
}
