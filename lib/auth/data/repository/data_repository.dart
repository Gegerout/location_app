import 'package:location_app/auth/data/data_sources/remote_data.dart';
import 'package:location_app/auth/domain/repository/repository_impl.dart';

class DataRepository extends Repository {
  @override
  Future<void> signinWithInstagram() async {
    await RemoteData().signinWithInstagram();
  }
}