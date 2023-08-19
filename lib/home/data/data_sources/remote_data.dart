import 'package:dio/dio.dart';
import 'package:location_app/home/data/models/image_location_model.dart';
import 'package:location_app/home/data/models/posts_images_model.dart';

class RemoteData {
  Future<List<PostsImagesModel>?> getImagesFromProfile(
      String accessToken) async {
    final Dio dio = Dio();
    const apiUrl = "https://graph.instagram.com/";
    final getImagesResult = await dio.get("${apiUrl}me/media",
        queryParameters: {
          'fields': "id,caption,media_url,permalink",
          "access_token": accessToken
        });
    if (getImagesResult.statusCode == 200) {
      final models = (getImagesResult.data["data"] as List)
          .map((e) => PostsImagesModel.fromJson(e)).toList();
      return models;
    }
    return null;
  }

  Future<List<ImageLocationModel>?> getLocationsFromPosts(List<String> permalinks, List<String> mediaUrls) async {
    final Dio dio = Dio();
    const apiUrl = "https://api.lamadava.com/a1/media";
    const geocodeUrl = "https://geocode-maps.yandex.ru/1.x/";
    List<ImageLocationModel> models = [];
    for (int i = 0; i < permalinks.length; i++) {
      final code = permalinks[i].split("/")[4];
      final apiRes = await dio.get(apiUrl, queryParameters: {
        "code": code,
        "access_key": "CiCkPmQeOITDhlcNFUAbAuI0YHl5n3Lp"
      });
      if(apiRes.statusCode == 200) {
        try {
          final instagramLocation = apiRes.data["items"][0]["location"]["name"];
          final latitude = apiRes.data["items"][0]["location"]["lat"];
          final longitude = apiRes.data["items"][0]["location"]["lng"];
          final res = await dio.get(geocodeUrl, queryParameters: {
            "apikey": "a4048f27-af7e-474c-af42-92cd0a03eccb",
            "geocode": "$longitude,$latitude",
            "format": "json"
          });
          final loadedLocation = res
              .data["response"]["GeoObjectCollection"]["featureMember"][0]["GeoObject"]["metaDataProperty"][
          "GeocoderMetaData"]["text"];
          final model = ImageLocationModel(instagramLocation, loadedLocation, latitude, longitude, mediaUrls[i]);
          models.add(model);
        } on NoSuchMethodError {
          continue;
        }
      } else {
        return null;
      }
    }
    return models;
  }
}
