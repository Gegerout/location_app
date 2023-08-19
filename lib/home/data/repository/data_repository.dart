import 'package:location_app/home/data/data_sources/local_data.dart';
import 'package:location_app/home/data/data_sources/remote_data.dart';
import 'package:location_app/home/domain/usecases/image_location_usecase.dart';
import 'package:location_app/home/domain/usecases/posts_data_usecase.dart';
import 'package:location_app/home/domain/usecases/posts_images_usecase.dart';

import '../../domain/repository/repository_impl.dart';

class DataRepository extends Repository {
  @override
  Future<PostsImagesUseCase?> getImagesFromProfile(String accessToken) async {
    final localData = await LocalData().getImagesFromStorage();
    if (localData != null) {
      final usecase = PostsImagesUseCase(localData);
      return usecase;
    } else {
      final data = await RemoteData().getImagesFromProfile(accessToken);
      if (data != null) {
        await LocalData().writeImagesToStorage(data);
        final usecase = PostsImagesUseCase(data);
        return usecase;
      } else {
        return null;
      }
    }
  }

  @override
  Future<ImageLocationUseCase?> getLocationsFromPosts(
      List<String> permalinks, List<String> mediaUrls) async {
    final localData = await LocalData().getLocationsFromStorage();
    if (localData != null) {
      final usecase = ImageLocationUseCase(localData);
      return usecase;
    } else {
      final data =
          await RemoteData().getLocationsFromPosts(permalinks, mediaUrls);
      if (data != null) {
        await LocalData().writeLocationsToStorage(data);
        final usecase = ImageLocationUseCase(data);
        return usecase;
      }
      return null;
    }
  }

  @override
  Future<PostsDataUseCase?> getPostsData(String accessToken) async {
    final imagesData = await getImagesFromProfile(accessToken);
    if (imagesData != null) {
      final locationData = await getLocationsFromPosts(
          imagesData.data.map((e) => e.permalink).toList(),
          imagesData.data.map((e) => e.mediaUrl).toList());
      final usecase = PostsDataUseCase(locationData, imagesData);
      return usecase;
    }
    return null;
  }
}
