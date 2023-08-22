import 'package:flutter/material.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location_app/auth/presentation/pages/welcome_page.dart';
import 'package:location_app/core/providers/main_provider.dart';
import 'package:location_app/home/presentation/pages/home_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://rrtxhumsrdoxrnqaohnc.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJydHhodW1zcmRveHJucWFvaG5jIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTEyMjg5NjAsImV4cCI6MjAwNjgwNDk2MH0.lQ3QP58TP1avQ8NgHFJnrXeA_i6NpK440Mw_hE8RZbQ',
  );
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterMapTileCaching.initialise();
  await FMTC.instance('mapStore').manage.createAsync();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
        fontFamily: "Futura BT"
      ),
      home: Scaffold(
        body: ref.watch(getUserDataProvider).when(
                data: (value) {
                  if(value != null) {
                    return HomePage(userModel: value);
                  }
                  return const WelcomePage();
                },
                error: (error, stacktrace) {
                  return AlertDialog(
                            title: Text(error.toString()),
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Ok"))
                            ],
                          );
                },
                loading: () => const Center(
                        child: CircularProgressIndicator(),
                )),
      ),
    );
  }
}