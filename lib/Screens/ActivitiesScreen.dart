import 'package:flutter/material.dart';
import 'package:tp_2/DTOs/Activity.dart';
import 'package:tp_2/Screens/ActivityDetailsScreen.dart';
import 'package:tp_2/Services/ActivitiesService.dart';

class ActivitiesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Activités'),
      ),
      body: FutureBuilder<List<Activity>>(
        future: ActivitiesService().getActivities(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error loading activities: ${snapshot.error}'),
            );
          } else {
            List<Activity> activities = snapshot.data ?? [];
            return ListView.builder(
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
            );
          }
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
