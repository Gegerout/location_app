import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_manager/photo_manager.dart';

Widget imageThumbnailWidget(AssetEntity asset, Uint8List? thumbData,
    Map<String, dynamic> locationData, WidgetRef ref) {
  if (thumbData != null) {
    return Material(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6)
      ),
      child: Column(
        children: [
          Image.memory(
            thumbData,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 4, right: 4),
            child: Text(
              "${locationData["city"]}, ${locationData["country"]}",
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  } else {
    return Container();
  }
}
