import 'package:dio/dio.dart';
import 'package:location_app/auth/data/models/user_model.dart';
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

  Future<UserModel?> getUserInstagramData(
      String accessToken, int userId, String email) async {
    final Dio dio = Dio();
    const apiUrl = "https://graph.instagram.com/";
    final accessResult =
        await dio.get("${apiUrl}access_token", queryParameters: {
      "grant_type": "ig_exchange_token",
      "client_secret": "0a9a45db5c6d7181db1fa791d3ee87eb",
      "access_token": accessToken
    });
    if (accessResult.statusCode == 200) {
      final dataResult =
          await dio.get("${apiUrl}v17.0/$userId", queryParameters: {
        "fields": "account_type,id,media_count,username",
        "access_token": accessResult.data["access_token"]
      });
      if (dataResult.statusCode == 200) {
        final userModel = UserModel(
            userId,
            accessResult.data["access_token"],
            accessResult.data["expires_in"],
            DateTime.now().toString(),
            dataResult.data["username"],
            dataResult.data["media_count"],
            dataResult.data["account_type"],
            email);
        await supabase.from("users").insert({
          "access_token": accessResult.data["access_token"],
          "user_id": userId,
          "expires_in": accessResult.data["expires_in"],
          "username": dataResult.data["username"],
          "media_count": dataResult.data["media_count"],
          "account_type": dataResult.data["account_type"],
          "email": email
        });
        return userModel;
      }
      return null;
    }
    return null;
  }

  Future<bool> createUserAccount(String email, String password) async {
    try {
      await supabase.auth.signUp(email: email, password: password);
      return true;
    } on AuthException {
      return false;
    }
    // final res = await supabase.auth.signUp(email: email, password: password);
    // if (res.user != null) {
    //   return true;
    // }
    // return false;
  }

  Future<UserModel?> signinToAccount(String email, String password) async {
    try {
      await supabase.auth.signInWithPassword(email: email, password: password);
      final data = await supabase.from("users").select("*").eq("email", email);
      final model = UserModel.fromJson(data[0]);
      return model;
    } on AuthException {
      return null;
    }
    // final res = await supabase.auth
    //     .signInWithPassword(email: email, password: password);
    // if (res.user != null) {
    //   final data = await supabase.from("users").select("*").eq("email", email);
    //   final model = UserModel.fromJson(data[0]);
    //   return model;
    // }
    // return null;
  }

  Future<bool> checkOtpCode(String email, String code) async {
    try {
      await supabase.auth
          .verifyOTP(token: code, type: OtpType.email, email: email);
      return true;
    } on AuthException {
      return false;
    }
  }
}
