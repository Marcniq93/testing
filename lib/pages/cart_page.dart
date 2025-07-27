import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  final List<String> cartItems; // List of item names in the cart

  const CartPage({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        backgroundColor: Colors.teal,
      ),
      body: cartItems.isEmpty
          ? const Center(
        child: Text(
          'Your cart is empty.',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final item = cartItems[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12.0),
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              leading: const Icon(Icons.shopping_cart, color: Colors.teal), // Cart icon
              title: Text(item),
              subtitle: const Text('Item in your cart'),
              onTap: () {
                // In a real app, you might navigate to the item's detail page
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Tapped on cart item: $item')),
                );
              },
              // You could add a trailing icon here for "remove from cart"
              // trailing: IconButton(
              //   icon: Icon(Icons.delete),
              //   onPressed: () {
              //     // Implement remove from cart logic
              //   },
              // ),
            ),
          );
        },
      ),
    );
  }
}
