import 'package:dio/dio.dart';
import 'package:location_app/home/data/models/posts_images_model.dart';

class RemoteData {
  Future<List<PostsImagesModel>?> getImagesFromProfile(
      String accessToken) async {
    final Dio dio = Dio();
    const apiUrl = "https://graph.instagram.com/";
    final getImagesResult = await dio.get("${apiUrl}me/media",
        queryParameters: {
          'fields': "id,caption,media_url",
          "access_token": accessToken
        });
    if (getImagesResult.statusCode == 200) {
      final models = (getImagesResult.data["data"] as List)
          .map((e) => PostsImagesModel.fromJson(e)).toList();
      return models;
    }
    return null;
  }
}
