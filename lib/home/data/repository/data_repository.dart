import 'package:location_app/home/data/data_sources/local_data.dart';
import 'package:location_app/home/data/data_sources/remote_data.dart';
import 'package:location_app/home/domain/usecases/image_location_usecase.dart';
import 'package:location_app/home/domain/usecases/posts_images_usecase.dart';

import '../../domain/repository/repository_impl.dart';

class DataRepository extends Repository {
  @override
  Future<PostsImagesUseCase?> getImagesFromProfile(String accessToken) async {
    final localData = await LocalData().getImagesFromStorage();
    if(localData != null) {
      getLocationsFromPosts(localData.map((e) => e.permalink).toList());
      final usecase = PostsImagesUseCase(localData);
      return usecase;
    } else {
      final data = await RemoteData().getImagesFromProfile(accessToken);
      if(data != null) {
        await LocalData().writeImagesToStorage(data);
        getLocationsFromPosts(data.map((e) => e.permalink).toList());
        final usecase = PostsImagesUseCase(data);
        return usecase;
      } else {
        return null;
      }
    }
  }

  @override
  Future<ImageLocationUseCase?> getLocationsFromPosts(List<String> permalinks) async {
    await RemoteData().getLocationsFromPosts(permalinks);
    return null;
  }
}