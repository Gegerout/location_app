import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location_app/home/presentation/pages/locations_page.dart';
import 'package:location_app/home/presentation/pages/profile_page.dart';
import 'package:location_app/home/presentation/providers/get_images_provider.dart';

import '../../../auth/data/models/user_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.userModel}) : super(key: key);

  final UserModel userModel;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  List pages = [];

  @override
  void initState() {
    super.initState();
    pages = [
      ProfilePage(userModel: widget.userModel),
      LocationsPage(userModel: widget.userModel)
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pages.elementAt(currentIndex),
      bottomNavigationBar:  BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.image),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.subtitles),
            label: 'Locations',
          ),
        ],
        currentIndex: currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
