import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location_app/home/data/repository/data_repository.dart';
import 'package:location_app/home/domain/usecases/posts_data_usecase.dart';

final getPostsDataProvider =
    FutureProvider.family<(PostsDataUseCase?, Position)?, String>((ref, accessToken) async {
  LocationPermission isPermission = await Geolocator.checkPermission();
  if (isPermission == LocationPermission.denied) {
    await Geolocator.requestPermission();
  }
  final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  final data = await DataRepository().getPostsData(accessToken);
  if (data != null) {
    return (data, position);
  }
  return null;
});
