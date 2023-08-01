import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location_app/home/presentation/providers/gallery_provider.dart';
import 'package:location_app/home/presentation/widgets/image_thumbnail_widget.dart';
import 'package:provider/provider.dart';

import '../../data/data_sources/local_data.dart';

class CountryListPage extends ConsumerStatefulWidget {
  const CountryListPage({Key? key}) : super(key: key);

  @override
  ConsumerState<CountryListPage> createState() => _CountryListPageState();
}

class _CountryListPageState extends ConsumerState<CountryListPage>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final imagesProvider = context.read<LocalData>();

    return Scaffold(
        appBar: AppBar(
          title: const Text("Gallery"),
        ),
        body: StreamBuilder(
          stream: imagesProvider.getImagesFromGallery(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data!.locationData[0]["thumbnailData"].length);
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.locationData.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                            itemCount: snapshot
                                .data!.locationData[index]["coordinates"].length,
                            itemBuilder: (context, subIndex) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.memory(
                                  Uint8List.fromList(List<int>.from(snapshot.data!.locationData[index]["thumbnailData"][subIndex])),
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              );
                            }),
                      ),
                      Text("${snapshot.data!.locationData[index]["location"]["city"]}, ${snapshot.data!.locationData[index]["location"]["country"]}")
                    ],
                  );
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
