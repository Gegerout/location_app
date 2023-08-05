import 'package:location_app/auth/domain/usecases/user_usecase.dart';

abstract class Repository {
  Future<void> signinWithInstagram();
}