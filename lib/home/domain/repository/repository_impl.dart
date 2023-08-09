import '../usecases/posts_images_usecase.dart';

abstract class Repository {
  Future<PostsImagesUseCase?> getImagesFromProfile(String accessToken);
}