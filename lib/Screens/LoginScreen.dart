import 'package:flutter/material.dart';
import 'package:tp_2/DTOs/User.dart';
import 'package:tp_2/Services/AuthService.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  final Function(bool) updateLoginStatus;

  LoginPage(this.updateLoginStatus, {super.key});

  // GlobalKey for the Form widget
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AuthService authService = AuthService();

  // Controllers for handling user input
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MIAGED'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Login',
                  icon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  icon: Icon(Icons.lock),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    String username = _usernameController.text;
                    String password = _passwordController.text;
                    User? result = await authService.login(username, password);

                    if (result != null) {
                      // Login successful
                      updateLoginStatus(true);
                    } else {
                      // Login failed
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Login failed. Please check your username and password.'),
                        ),
                      );
                    }
                  }
                },
                child: Text('Se connecter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
