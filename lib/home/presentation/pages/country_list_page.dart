import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location_app/home/presentation/providers/gallery_provider.dart';
import 'package:location_app/home/presentation/widgets/image_thumbnail_widget.dart';

class CountryListPage extends ConsumerWidget {
  const CountryListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Country List"),
        ),
        body: ref.watch(getCitiesProvider).when(
            data: (value) {
              return ListView.builder(
                itemCount: value.$1.locationData.length,
                  itemBuilder: (context, index) {
                return Text(value.$2[index]["city"]);
              });
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
            )));
  }
}