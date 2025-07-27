import 'package:flutter/material.dart';

class WishlistPage extends StatelessWidget { // Corrected class name
  final List<String> wishlistItems; // List of item names in wishlist

  const WishlistPage({super.key, required this.wishlistItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wishlist'),
        backgroundColor: Colors.teal,
      ),
      body: wishlistItems.isEmpty
          ? const Center(
        child: Text(
          'Your wishlist is empty.',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: wishlistItems.length,
        itemBuilder: (context, index) {
          final item = wishlistItems[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12.0),
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              leading: const Icon(Icons.favorite, color: Colors.red),
              title: Text(item),
              subtitle: const Text('Item in your wishlist'),
              onTap: () {
                // In a real app, you might navigate to the item's detail page
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Tapped on wishlist item: $item')),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
