import 'package:location_app/home/data/data_sources/remote_data.dart';
import 'package:location_app/home/domain/usecases/posts_images_usecase.dart';

import '../../domain/repository/repository_impl.dart';

class DataRepository extends Repository {
  @override
  Future<PostsImagesUseCase?> getImagesFromProfile(String accessToken) async {
    final data = await RemoteData().getImagesFromProfile(accessToken);
    if(data != null) {
      final usecase = PostsImagesUseCase(data);
      return usecase;
    }
    return null;
  }
}