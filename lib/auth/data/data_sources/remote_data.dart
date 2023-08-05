import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

class RemoteData {
  final supabase = Supabase.instance.client;
  Future<void> signinWithInstagram() async {
    launchUrlString("https://api.instagram.com/oauth/authorize?client_id=654282726370699&redirect_uri=https://evgeniymuravyov.pythonanywhere.com/auth&scope=user_profile,user_media&response_type=code");
  }
}