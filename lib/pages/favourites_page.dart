import 'package:flutter/material.dart';

class FavouritesPage extends StatelessWidget { // Corrected class name
  final List<String> favouriteItems; // List of item names in favourites

  const FavouritesPage({super.key, required this.favouriteItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Favourites'),
        backgroundColor: Colors.teal,
      ),
      body: favouriteItems.isEmpty
          ? const Center(
        child: Text(
          'You have no favourite items yet.',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: favouriteItems.length,
        itemBuilder: (context, index) {
          final item = favouriteItems[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12.0),
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              leading: const Icon(Icons.star, color: Colors.amber), // Star icon for favourites
              title: Text(item),
              subtitle: const Text('Your favourite item'),
              onTap: () {
                // In a real app, you might navigate to the item's detail page
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Tapped on favourite item: $item')),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
