import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tp_2/DTOs/User.dart';
import 'package:intl/intl.dart';
import 'package:tp_2/Services/AuthService.dart';

class ProfileScreen extends StatefulWidget {
  final Function(bool) updateLoginStatus;

  const ProfileScreen(this.updateLoginStatus, {Key? key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController _addressController;
  late TextEditingController _postalCodeController;
  late TextEditingController _cityController;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    User currentUser = AuthService.currentUser!;
    _addressController = TextEditingController(text: currentUser.address);
    _postalCodeController =
        TextEditingController(text: currentUser.postalCode.toString());
    _cityController = TextEditingController(text: currentUser.city);
    _selectedDate = currentUser.birthday; // Initialize selected date
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              readOnly: true,
              initialValue: AuthService.currentUser!.username,
              decoration: InputDecoration(labelText: 'Login'),
            ),
            SizedBox(height: 16),
            TextFormField(
              readOnly: true,
              initialValue: '********',
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _addressController,
              decoration: InputDecoration(labelText: 'Adresse'),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _postalCodeController,
              decoration: InputDecoration(labelText: 'Code Postal'),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _cityController,
              decoration: InputDecoration(labelText: 'Ville'),
            ),
            SizedBox(height: 24),
            TextButton(
              onPressed: () {
                _selectDate(context); // Open date picker dialog
              },
              child: Row(
                children: [
                  Icon(Icons.calendar_today),
                  SizedBox(width: 8),
                  Text(
                      'Anniversaire: ${DateFormat('dd/MM/yyyy').format(_selectedDate)}'),
                ],
              ),
            ),
            SizedBox(height: 48),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Validate modifications
                    User currentUser = AuthService.currentUser!;
                    currentUser.address = _addressController.text;
                    currentUser.postalCode = _postalCodeController.text;
                    currentUser.city = _cityController.text;
                    currentUser.birthday = _selectedDate;

                    AuthService authService = AuthService();

                    // Update user in the database
                    authService.updateUser(currentUser);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Profil mis à jour avec succès')),
                    );
                  },
                  child: Text('Valider'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Logout
                    AuthService.logout();
                    widget.updateLoginStatus(false);
                  },
                  child: Text('Se déconnecter'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }
}
