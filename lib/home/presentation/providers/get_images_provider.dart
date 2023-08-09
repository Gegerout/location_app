import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location_app/home/data/models/posts_images_model.dart';
import 'package:location_app/home/data/repository/data_repository.dart';

final getImagesFromProfileProvider = FutureProvider.family<List<PostsImagesModel>?, String>((ref, accessToken) async {
   final data = await DataRepository().getImagesFromProfile(accessToken);
   if(data != null) {
     return data.data;
   }
   return null;
});