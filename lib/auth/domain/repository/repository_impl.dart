import 'package:location_app/auth/domain/usecases/user_usecase.dart';

abstract class Repository {
  Future<void> addInstagramAccount();
  Future<bool> createUserAccount(String email, String password);
  Future<bool> checkOtpCode(String email, String code);
  Future<UserUseCase?> getUserInstagramData(String accessToken, int userId, String email);
  Future<UserUseCase?> signinToAccount(String email, String password);
  Future<UserUseCase?> getUserDataFromStorage();
}