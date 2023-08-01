import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location_app/home/data/data_sources/local_data.dart';
import 'package:location_app/home/presentation/pages/gallery_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as provider;

import 'home/presentation/pages/country_list_page.dart';

void main() {
  runApp(provider.MultiProvider(providers: [
    provider.ChangeNotifierProvider(create: (context) => LocalData()),
  ], child: const ProviderScope(child: MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: CountryListPage()
      ),
    );
  }
}