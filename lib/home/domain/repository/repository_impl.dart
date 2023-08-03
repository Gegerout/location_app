import '../usecases/images_usecase.dart';

abstract class Repository {
  // Future<ImagesUseCase> getImagesFromGallery();
  Future<List<String>> getLocations();
}