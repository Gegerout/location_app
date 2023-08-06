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

  Future<bool> createUserAccount(String email, String password) async {
    try {
      await supabase.auth.signUp(email: email, password: password);
      return true;
    } on AuthException {
      return false;
    }
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
