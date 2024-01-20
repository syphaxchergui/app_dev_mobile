import 'package:flutter/material.dart';
import 'package:tp_2/DTOs/Activity.dart';
import 'package:tp_2/Screens/ActivityDetailsScreen.dart';

class ActivitiesListScreen extends StatelessWidget {
  final List<Activity> activities = [
    Activity(
      imageLink: 'https://picsum.photos/250?image=9',
      title: 'Activité 1',
      location: 'Lieu 1',
      price: 25.0,
      minPersons: 2,
      category: 'Sport',
    ),
    Activity(
      imageLink: 'https://picsum.photos/250?image=10',
      title: 'Activité 2',
      location: 'Lieu 2',
      price: 30.0,
      minPersons: 3,
      category: 'Sport',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Activités'),
      ),
      body: ListView.builder(
        itemCount: activities.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              activities[index].title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              '${activities[index].location} - ${activities[index].price} \$',
            ),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                activities[index].imageLink,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            onTap: () {
              _navigateToActivityDetails(context, activities[index]);
            },
            trailing: Icon(Icons.arrow_forward_ios),
          );
        },
      ),
    );
  }

  void _navigateToActivityDetails(BuildContext context, Activity activity) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ActivityDetailScreen(activity: activity),
      ),
    );
  }
}
