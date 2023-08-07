abstract class Repository {
  Future<void> addInstagramAccount();
  Future<bool> createUserAccount(String email, String password);
  Future<bool> checkOtpCode(String email, String code);
  Future<bool> getLongAccessToken(String accessToken, int userId);
}