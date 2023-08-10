import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location_app/home/data/models/posts_images_model.dart';
import 'package:location_app/home/data/repository/data_repository.dart';
import 'package:location_app/home/domain/usecases/posts_data_usecase.dart';

final getImagesFromProfileProvider = FutureProvider.family<PostsDataUseCase?, String>((ref, accessToken) async {
   final data = await DataRepository().getPostsData(accessToken);
   if(data != null) {
     return data;
   }
   return null;
});