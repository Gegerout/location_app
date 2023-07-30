import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_manager/photo_manager.dart';

Widget imageThumbnailWidget(AssetEntity asset, Uint8List? thumbData,
    Map<String, dynamic> locationData, WidgetRef ref) {
  if (thumbData != null) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Image.memory(
            thumbData,
            fit: BoxFit.cover,
          ),
          Text("${locationData["city"]}, ${locationData["country"]}")
        ],
      ),
    );
  } else {
    return Container();
  }
}
