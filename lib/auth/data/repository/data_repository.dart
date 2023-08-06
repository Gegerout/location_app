import 'package:location_app/auth/data/data_sources/remote_data.dart';
import 'package:location_app/auth/domain/repository/repository_impl.dart';

class DataRepository extends Repository {
  @override
  Future<void> addInstagramAccount() async {
    await RemoteData().addInstagramAccount();
  }

  @override
  Future<bool> createUserAccount(String email, String password) async {
    final data = await RemoteData().createUserAccount(email, password);
    return data;
  }

  @override
  Future<bool> checkOtpCode(String email, String code) async {
    final data = await RemoteData().checkOtpCode(email, code);
    return data;
  }
}