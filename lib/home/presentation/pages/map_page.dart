import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../../../auth/data/models/user_model.dart';
import '../providers/get_posts_data.dart';

class MapPage extends ConsumerWidget {
  const MapPage({Key? key, required this.userModel}) : super(key: key);

  final UserModel userModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Map page"),
      ),
      body: ref.watch(getPostsDataProvider(userModel.accessToken)).when(
          data: (value) {
            Map<String, dynamic> cities = {};

            for (var element in value!.$1!.locationData!.data) {
              final location = element.loadedLocation.split(",");
              if (location.length >= 2) {
                if (!cities
                    .containsKey("${element.latitude}, ${element.longitude}")) {
                  cities.addAll({
                    "${element.latitude}, ${element.longitude}": {
                      "urls": [element.mediaUrl],
                      "point": [element.latitude, element.longitude]
                    },
                  });
                } else {
                  final List permalinks =
                      cities["${element.latitude}, ${element.longitude}"]
                          ["urls"];
                  permalinks.add(element.mediaUrl);
                  cities.update(
                      "${element.latitude}, ${element.longitude}",
                      (value) => {
                            "urls": permalinks,
                            "point": [element.latitude, element.longitude]
                          });
                }
              } else {
                cities.addAll({
                  "${element.latitude}, ${element.longitude}": {
                    "urls": [element.mediaUrl],
                    "point": [element.latitude, element.longitude]
                  },
                });
              }
            }

            print(cities);

            List<Marker> markers = value.$1!.locationData!.data
                .map((e) => Marker(
                    point: LatLng(e.latitude, e.longitude),
                    builder: (context) => InkWell(
                          onTap: () {
                            final citiesData = cities.values
                                .where((element) =>
                                    element["point"][0] == e.latitude &&
                                    element["point"][1] == e.longitude)
                                .first;
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return SizedBox(
                                      height: 300,
                                      child: GridView.builder(
                                          shrinkWrap: true,
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 4),
                                          itemCount: citiesData["urls"].length,
                                          itemBuilder: (context, index) {
                                            return SizedBox(
                                                height: 100,
                                                width: 100,
                                                child: CachedNetworkImage(
                                                  imageUrl: citiesData["urls"]
                                                      [index],
                                                  fit: BoxFit.cover,
                                                  progressIndicatorBuilder:
                                                      (context, url,
                                                              downloadProgress) =>
                                                          Center(
                                                    child: SizedBox(
                                                      height: 40,
                                                      width: 40,
                                                      child: CircularProgressIndicator(
                                                          value:
                                                              downloadProgress
                                                                  .progress),
                                                    ),
                                                  ),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          const Icon(
                                                    Icons.error,
                                                    color: Colors.redAccent,
                                                  ),
                                                ));
                                          }));
                                });
                          },
                          child: const Icon(
                            Icons.pin_drop,
                            size: 30,
                            color: Colors.redAccent,
                          ),
                        )))
                .toList();

            markers.add(Marker(
                point: LatLng(value.$2.latitude, value.$2.longitude),
                builder: (context) => const Icon(
                      Icons.person,
                      size: 30,
                      color: Colors.blue,
                    )));

            return FlutterMap(
              options: MapOptions(
                  center: LatLng(value.$2.latitude, value.$2.longitude),
                  zoom: 14),
              children: [
                TileLayer(
                  tileProvider: FMTC.instance('mapStore').getTileProvider(),
                  urlTemplate:
                      "https://a.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}@2x.png",
                  userAgentPackageName: 'com.locationapp',
                ),
                MarkerLayer(
                  markers: markers,
                ),
              ],
            );
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
    );
  }
}
