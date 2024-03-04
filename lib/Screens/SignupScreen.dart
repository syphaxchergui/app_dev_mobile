import 'package:flutter/material.dart';
import 'package:tp_2/DTOs/User.dart';
import 'package:tp_2/Services/AuthService.dart';

// ignore: must_be_immutable
class SignUpPage extends StatelessWidget {
  final Function(bool) updateLoginStatus;
  final Function(bool) updateInscriptionPage;

  SignUpPage(this.updateLoginStatus, this.updateInscriptionPage, {super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AuthService authService = AuthService();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MIAGED - Inscription'),
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
                    return 'Veuillez entrer votre nom d\'utilisateur';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  icon: Icon(Icons.lock),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer votre mot de passe';
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
                    User? result = await authService.signUp(username, password);

                    if (result != null) {
                      // Sign up successful
                      updateLoginStatus(true);
                    } else {
                      // Sign up failed
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text('Inscription échouée. Veuillez réessayer.'),
                        ),
                      );
                    }
                  }
                },
                child: Text('S\'inscrire'),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Déjà inscrit ? ',
                    style: TextStyle(fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () {
                      updateInscriptionPage(false);
                    },
                    child: Text(
                      'Se Connecter',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.redAccent,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
