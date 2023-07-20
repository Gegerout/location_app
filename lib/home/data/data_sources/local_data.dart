import 'package:location_app/home/data/models/images_model.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';

class LocalData {
  Future<LatLng> getLocationDataFromImage(String id) async {
    final status = await Permission.photos.request();

    if (status.isGranted) {
      final albums = await PhotoManager.getAssetPathList(
        type: RequestType.image,
        onlyAll: true,
      );

      final images = await albums[0].getAssetListRange(start: 0, end: 1000000);
      final file = images.where((element) => element.id == id).first;
      return file.latlngAsync();
    } else {
      throw Error();
    }
  }

  Future<ImagesModel> getImagesFromGallery() async {
    final status = await Permission.photos.request();

    if (status.isGranted) {
      final albums = await PhotoManager.getAssetPathList(
        type: RequestType.image,
        onlyAll: true,
      );

      final images = await albums[0].getAssetListRange(start: 0, end: 1000000);
      final models = ImagesModel(images);
      return models;
    } else {
      throw Error();
    }
  }
}
