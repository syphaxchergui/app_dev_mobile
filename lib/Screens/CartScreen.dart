import 'package:flutter/material.dart';
import 'package:tp_2/DTOs/Activity.dart';
import 'package:tp_2/DTOs/User.dart';
import 'package:tp_2/Services/AuthService.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Activity> _cartItems = [];

  @override
  void initState() {
    super.initState();
    _loadCartItems();
  }

  Future<void> _loadCartItems() async {
    User currentUser = AuthService.currentUser!;
    setState(() {
      _cartItems = currentUser.cart;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Panier'),
      ),
      body: _buildCartList(),
    );
  }

  Widget _buildCartList() {
    double totalPrice = 0;

    if (_cartItems.isEmpty) {
      return Center(
        child: Text('Panier vide.'),
      );
    } else {
      // Calculate total price
      for (var item in _cartItems) {
        totalPrice += item.price;
      }

      return Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _cartItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_cartItems[index].title),
                  subtitle: Text(
                    '${_cartItems[index].location} - ${_cartItems[index].price} \$',
                  ),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      _cartItems[index].imageLink,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      _removeFromCart(index);
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Total: \$${totalPrice.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      );
    }
  }

  void _removeFromCart(int index) {
    setState(() {
      _cartItems.removeAt(index);
    });
    AuthService().updateCart(_cartItems);
  }
}
