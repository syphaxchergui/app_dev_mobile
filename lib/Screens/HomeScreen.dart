import 'package:flutter/material.dart';
import 'package:tp_2/Screens/ActivitiesScreen.dart';

class HomeScreen extends StatefulWidget {
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
        page = Placeholder(color: Colors.green);
        break;
      case 2:
        page = Placeholder(color: Colors.red);
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
            // Customizing the "Activities" item
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
