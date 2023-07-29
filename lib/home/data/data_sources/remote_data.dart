import 'dart:math';

import 'package:dio/dio.dart';

class RemoteData {
  final double earthRadius = 6371.0;

  Future<List<String>> getLocationDataFromCoordinates(double longitude, double latitude) async {
    const apiUrl = "https://geocode-maps.yandex.ru/1.x/";
    final Dio dio = Dio();
    final res = await dio.get(apiUrl, queryParameters: {
      "apikey": "a4048f27-af7e-474c-af42-92cd0a03eccb",
      "geocode": "$longitude,$latitude",
      "format": "json"
    });
    final List<String> answer = res
        .data["response"]["GeoObjectCollection"]["featureMember"][0]["GeoObject"]["metaDataProperty"][
    "GeocoderMetaData"]["text"].split(",");
    return answer;
  }
}