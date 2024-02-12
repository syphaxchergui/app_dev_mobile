import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tp_2/DTOs/User.dart';

class AuthService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static User? currentUser;

  Future<User?> login(String username, String password) async {
    try {
      // Query Firestore for a user document with the provided username
      QuerySnapshot userSnapshot = await _firestore
          .collection('users')
          .where('username', isEqualTo: username)
          .get();

      // Check if a user with the provided username exists
      if (userSnapshot.docs.isNotEmpty) {
        var userDocument = userSnapshot.docs.first;

        if (userDocument['password'] != password) {
          return null;
        }
        // Create a User object from the retrieved data
        currentUser = User(
          id: userDocument.id,
          username: userDocument['username'],
          address: userDocument['address'],
          birthday: userDocument['birthday'].toDate(),
          postalCode: userDocument['postalCode'],
          city: userDocument['city'],
        );

        // Return the authenticated user
        return currentUser;
      } else {
        // No user found with the provided username
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static logout() {
    currentUser = null;
  }

  updateUser(User user) async {
    try {
      await _firestore.collection('users').doc(user.id).update({
        'address': user.address,
        'postalCode': user.postalCode,
        'city': user.city,
        'birthday': user.birthday,
      });
      currentUser = user;
    } catch (e) {
      print(e.toString());
    }
  }
}
