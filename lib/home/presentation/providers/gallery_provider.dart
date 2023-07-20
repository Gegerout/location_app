import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repository/data_repository.dart';

final galleryProvider = FutureProvider((ref) async {
   final data = await DataRepository().getImagesFromGallery();
   return data.images;
});