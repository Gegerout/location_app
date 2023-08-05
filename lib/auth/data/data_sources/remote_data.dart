import 'package:receive_intent/receive_intent.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class RemoteData {
  final supabase = Supabase.instance.client;

  Future<void> signinWithInstagram() async {
    await launchUrl(
        Uri.parse(
            "https://api.instagram.com/oauth/authorize?client_id=654282726370699&redirect_uri=https://evgeniymuravyov.pythonanywhere.com/auth&scope=user_profile,user_media&response_type=code"),
        mode: LaunchMode.externalNonBrowserApplication);
  }
}
