import 'package:location_app/home/data/data_sources/local_data.dart';
import 'package:location_app/home/domain/usecases/images_usecase.dart';

import '../../domain/repository/repository_impl.dart';

class DataRepository extends Repository {
  @override
  Future<ImagesUseCase> getImagesFromGallery() async {
    final images = await LocalData().getImagesFromGallery();
    final usecase = ImagesUseCase(images);
    return usecase;
  }
}