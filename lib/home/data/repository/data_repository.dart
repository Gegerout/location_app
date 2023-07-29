import 'package:location_app/home/data/data_sources/local_data.dart';
import 'package:location_app/home/data/data_sources/remote_data.dart';

import '../../domain/repository/repository_impl.dart';

class DataRepository extends Repository {
  @override
  Future<void> getImagesFromGallery() async {
    final imagesData = await LocalData().getImagesFromGallery();
    final imagesLocationData = await LocalData().getLocationDataFromImages();
    if (imagesLocationData != null) {
      final int imagesCount = int.parse(imagesLocationData["imagesCount"]);
      if (imagesCount <= imagesData.$1.length) {}
    } else {
      for (int i = 0; i < imagesData.$1.length; i++) {
        final latLonData =
            await LocalData().getCoordinatesDataFromImage(imagesData.$1[i].id);
        if(latLonData.longitude != 0.0 && latLonData.latitude != 0.0 && latLonData.latitude != null && latLonData.longitude != null) {
          final locationData = await RemoteData()
              .getLocationDataFromCoordinates(latLonData.longitude!, latLonData.latitude!);
        } else {
          continue;
        }
      }
    }
  }
}
