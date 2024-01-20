import 'package:flutter/material.dart';
import 'package:tp_2/DTOs/Activity.dart';

class ActivityDetailScreen extends StatelessWidget {
  final Activity activity;

  ActivityDetailScreen({required this.activity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails de l\'Activité'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(activity.imageLink),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Titre: ${activity.title}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Catégorie: ${activity.category}',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 8),
                Text(
                  'Lieu: ${activity.location}',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 8),
                Text(
                  'Min. personnes: ${activity.minPersons}',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 8),
                Text(
                  'Prix: ${activity.price} \$',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          Spacer(), // Add Spacer to push the footer to the bottom
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Logique pour ajouter l'activité au panier
                _addToCart(activity, context);
              },
              child: Text('Ajouter au panier'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Fonction pour ajouter l'activité au panier (simulation)
  void _addToCart(Activity activity, BuildContext context) {
    // Logique pour ajouter l'activité au panier (simulé)
    // Vous pouvez implémenter la logique réelle ici, comme ajouter en base de données
    print('Activité ajoutée au panier : ${activity.title}');
    // Afficher une boîte de dialogue ou une notification pour indiquer que l'activité a été ajoutée au panier
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Activité ajoutée au panier : ${activity.title}'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(16),
        showCloseIcon: true,
      ),
    );
  }
}
