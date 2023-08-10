import 'package:location_app/home/domain/usecases/image_location_usecase.dart';
import 'package:location_app/home/domain/usecases/posts_images_usecase.dart';

class PostsDataUseCase {
  final ImageLocationUseCase? locationData;
  final PostsImagesUseCase? imagesData;

  PostsDataUseCase(this.locationData, this.imagesData);
}