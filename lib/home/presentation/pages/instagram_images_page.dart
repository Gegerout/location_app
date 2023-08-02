import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  List<Map<String, dynamic>> _locations = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _getMedia();
  }

  Future<void> _getMedia() async {
    final String accessToken = ''; // Replace with your actual access token

    final response = await http.get(
      Uri.parse('https://graph.instagram.com/me/media?fields=id,caption,media_type,media_url,thumbnail_url,timestamp&access_token=$accessToken'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> mediaList = data['data'];

      for (final media in mediaList) {
        final mediaId = media['id'];
        final mediaUrl = media['permalink'];

        final mediaResponse = await http.get(Uri.parse(mediaUrl));
        final document = parse(mediaResponse.body);

        final locationElementLat = document.querySelector('meta[property="place:location:latitude"]');
        final locationElementLng = document.querySelector('meta[property="place:location:longitude"]');

        if (locationElementLat != null && locationElementLng != null) {
          final latitude = locationElementLat.attributes['content'];
          final longitude = locationElementLng.attributes['content'];

          _locations.add({'latitude': latitude, 'longitude': longitude});
        }
      }

      setState(() {
        _loading = false;
      });
    } else {
      print('Failed to load data: ${response.statusCode}');
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Locations'),
      ),
      body: _loading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: _locations.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Location $index'),
            subtitle: Text('Lat: ${_locations[index]['latitude']}, Lng: ${_locations[index]['longitude']}'),
          );
        },
      ),
    );
  }
}