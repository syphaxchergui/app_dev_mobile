import 'package:flutter/material.dart';
import 'package:tp_2/Screens/ActivitiesScreen.dart';
import 'package:tp_2/Screens/CartScreen.dart';
import 'package:tp_2/Screens/ProfileScreen.dart';

class HomeScreen extends StatefulWidget {
  final Function(bool) updateLoginStatus;

  const HomeScreen(this.updateLoginStatus, {Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // var pageTitles = ['Activités', 'Panier', 'Profil'];

    Widget page;
    switch (selectedIndex) {
      case 0:
        page = ActivitiesListScreen();
        break;
      case 1:
        page = CartScreen();
        break;
      case 2:
        page = ProfileScreen(widget.updateLoginStatus);
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(pageTitles[selectedIndex]),
      // ),
      body: page,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Activités',
            activeIcon: Icon(Icons.list, color: Colors.blue),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Panier',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        selectedLabelStyle: selectedIndex == 0
            ? const TextStyle(color: Colors.blue)
            : TextStyle(color: Colors.redAccent),
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
      ),
    );
  }
}
