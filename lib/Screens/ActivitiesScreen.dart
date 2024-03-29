import 'package:flutter/material.dart';
import 'package:tp_2/DTOs/Activity.dart';
import 'package:tp_2/Screens/ActivityDetailsScreen.dart';
import 'package:tp_2/Services/ActivitiesService.dart';
import 'package:tp_2/utils/categories.dart';

class ActivitiesListScreen extends StatefulWidget {
  @override
  _ActivitiesListScreenState createState() => _ActivitiesListScreenState();
}

class _ActivitiesListScreenState extends State<ActivitiesListScreen>
    with SingleTickerProviderStateMixin {
  late Future<List<Activity>> _activitiesFuture;
  String _selectedCategory = 'Toutes';
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _activitiesFuture = ActivitiesService().getActivities();
    _tabController = TabController(
        length: categories.length,
        vsync: this); // Change length to the number of tabs
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Activités'),
      ),
      body: Column(
        children: [
          // TabBar to select category
          TabBar(
            controller: _tabController,
            tabs: categories.map((category) => Tab(text: category)).toList(),
            onTap: (index) {
              setState(() {
                _selectedCategory = categories[index];
              });
            },
          ),
          // FutureBuilder to load activities
          FutureBuilder<List<Activity>>(
            future: _activitiesFuture,
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
                // Filter activities based on selected category
                if (_selectedCategory != 'Toutes') {
                  activities = activities
                      .where((a) => a.category == _selectedCategory)
                      .toList();
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: activities.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          activities[index].title,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
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
                          _navigateToActivityDetails(
                              context, activities[index]);
                        },
                        trailing: Icon(Icons.arrow_forward_ios),
                      );
                    },
                  ),
                );
              }
            },
          ),
        ],
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
