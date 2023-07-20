import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

Future<Widget> imageThumbnailWidget(AssetEntity asset) async {
  final thumbData = await asset.thumbnailData;
  if (thumbData != null) {
    return InkWell(
      onTap: () {
        //LocalData().getLocationDataFromImage(asset.id);
      },
      child: Image.memory(
        thumbData,
        fit: BoxFit.cover,
      ),
    );
  } else {
    return Container();
  }
}