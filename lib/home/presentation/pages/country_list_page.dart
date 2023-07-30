// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:location_app/home/presentation/widgets/image_thumbnail_widget.dart';
// import 'package:provider/provider.dart';
//
// import '../../data/data_sources/local_data.dart';
//
// class CountryListPage extends ConsumerWidget {
//   const CountryListPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final imagesProvider = context.read<LocalData>();
//
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text("Country List"),
//         ),
//         body: StreamBuilder(
//           stream: imagesProvider.getImagesFromGallery(),
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               print(snapshot.data?.locationData);
//               return ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: snapshot.data!.locationData.length,
//                 itemBuilder: (context, index) {
//                   return Column(
//                     children: [
//                       SizedBox(
//                         height: 80,
//                         child: ListView.builder(
//                           scrollDirection: Axis.horizontal,
//                           itemCount: snapshot.data!.locationData[index]['coordinates'].length,
//                           itemBuilder: (context, index2) {
//                             return SizedBox(width: 80,
//                                 height: 80,
//                                 child: imageCardWidget(
//                                     snapshot.data!.thumbnailData[index]));
//                           },
//                         ),
//                       ),
//                       Text("${snapshot.data!.locationData[index]["location"]["city"]}, ${snapshot.data!.locationData[index]["location"]["country"]}")
//                     ],
//                   );
//                 },
//               );
//             } else {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//           },
//         ));
//   }
// }