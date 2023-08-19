import '../usecases/image_location_usecase.dart';
import '../usecases/posts_data_usecase.dart';
import '../usecases/posts_images_usecase.dart';

abstract class Repository {
  Future<PostsImagesUseCase?> getImagesFromProfile(String accessToken);

  Future<ImageLocationUseCase?> getLocationsFromPosts(
      List<String> permalinks, List<String> mediaUrls);

  Future<PostsDataUseCase?> getPostsData(String accessToken);
}
