import 'package:dio/dio.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class RemoteData {
  final supabase = Supabase.instance.client;

  Future<void> addInstagramAccount() async {
    await launchUrl(
        Uri.parse(
            "https://api.instagram.com/oauth/authorize?client_id=654282726370699&redirect_uri=https://evgeniymuravyov.pythonanywhere.com/auth&scope=user_profile,user_media&response_type=code"),
        mode: LaunchMode.externalApplication);
  }

  Future<bool> getLongAccessToken(String accessToken, int userId) async {
    final Dio dio = Dio();
    const apiUrl = "https://graph.instagram.com/access_token";
    final res = await dio.get(apiUrl, queryParameters: {
      "grant_type": "ig_exchange_token",
      "client_secret": "0a9a45db5c6d7181db1fa791d3ee87eb",
      "access_token": accessToken
    });
    if(res.statusCode == 200) {
      supabase.from("users").insert({
        "access_token": res.data["access_token"], "user_id": userId,
        "expires_in": res.data["expires_in"]
      });
      return true;
    }
    return false;
  }

  Future<bool> createUserAccount(String email, String password) async {
    // try {
    //   await supabase.auth.signUp(email: email, password: password);
    //   return true;
    // } on AuthException {
    //   return false;
    // }
    final res = await supabase.auth.signUp(email: email, password: password);
    if(res.user != null) {
      return true;
    }
    return false;
  }

  Future<bool> checkOtpCode(String email, String code) async {
    try {
      await supabase.auth.verifyOTP(token: code, type: OtpType.email, email: email);
      return true;
    } on AuthException {
      return false;
    }
  }
}
