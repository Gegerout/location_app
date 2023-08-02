import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location_app/home/presentation/providers/gallery_provider.dart';
import 'package:location_app/home/presentation/widgets/image_thumbnail_widget.dart';
import 'package:provider/provider.dart';

import '../../data/data_sources/local_data.dart';

class CountryListPage extends ConsumerWidget {
  const CountryListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imagesProvider = context.read<LocalData>();

    return Scaffold(
        appBar: AppBar(
          title: const Text("Country List"),
        ),
        body:StreamBuilder(
          stream: imagesProvider.getImagesFromGallery(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.cities.length,
                itemBuilder: (context, index) {
                  return Text(snapshot.data!.cities[index]);
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}