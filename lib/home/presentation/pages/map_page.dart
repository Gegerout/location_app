import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
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
        title: const Text("Locations page"),
      ),
      body: ref.watch(getPostsDataProvider(userModel.accessToken)).when(
          data: (value) {
            List<Marker> markers = value!.locationData!.data
                .map((e) => Marker(
                    point: LatLng(e.latitude, e.longitude),
                    builder: (context) => const Icon(
                          Icons.pin_drop,
                          size: 30,
                          color: Colors.redAccent,
                        )))
                .toList();

            return FlutterMap(
              options: MapOptions(
                  center: LatLng(value.locationData!.data.last.latitude,
                      value.locationData!.data.last.longitude),
                  zoom: 14),
              children: [
                TileLayer(
                  urlTemplate:
                      "https://a.basemaps.cartocdn.com/light_nolabels/{z}/{x}/{y}@2x.png",
                  userAgentPackageName: 'com.example.app',
                ),
                MarkerLayer(
                  markers: markers,
                ),
                // PolylineLayer(
                //   polylineCulling: false,
                //   polylines: [
                //     Polyline(points: value.$3, color: AppColors.primaryColor, strokeWidth: 3,)
                //   ],
                // )
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
