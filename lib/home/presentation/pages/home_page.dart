import 'package:flutter/material.dart';
import 'package:location_app/home/presentation/pages/locations_page.dart';
import 'package:location_app/home/presentation/pages/map_page.dart';
import 'package:location_app/home/presentation/pages/profile_page.dart';

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
      LocationsPage(userModel: widget.userModel),
      MapPage(userModel: widget.userModel),
      ProfilePage(userModel: widget.userModel)
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
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Locations',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
