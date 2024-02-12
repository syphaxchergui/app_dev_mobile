import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tp_2/DTOs/Activity.dart';

class ActivitiesService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Activity>> getActivities() async {
    try {
      QuerySnapshot activitiesSnapshot =
          await _firestore.collection('activities').get();

      List<Activity> activities = activitiesSnapshot.docs.map((activityDoc) {
        return Activity(
          imageLink: activityDoc['imageLink'],
          title: activityDoc['title'],
          category: activityDoc['category'],
          location: activityDoc['location'],
          minPersons: activityDoc['minPersons'],
          price: activityDoc['price'].toDouble(),
        );
      }).toList();

      return activities;
    } catch (e) {
      print('Error retrieving activities: $e');
      return [];
    }
  }
}
