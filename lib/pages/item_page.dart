import 'package:flutter/material.dart';

class ItemDetailPage extends StatelessWidget {
  final Map<String, dynamic> item;
  final bool isInWishlist;
  final bool isInFavourite;
  final Function(String) onToggleWishlist;
  final Function(String) onToggleFavourite;
  final Function(String) onAddToCart;

  const ItemDetailPage({
    super.key,
    required this.item,
    required this.isInWishlist,
    required this.isInFavourite,
    required this.onToggleWishlist,
    required this.onToggleFavourite,
    required this.onAddToCart,
  });

  // Placeholder for report item action (same as in MarketplacePage)
  void _reportItem(BuildContext context, String itemName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$itemName has been reported.')),
    );
    print('$itemName has been reported.');
  }

  @override
  Widget build(BuildContext context) {
    // Retrieve rating data
    final double averageRating = item['averageRating'] ?? 0.0;
    final int numberOfReviews = item['numberOfReviews'] ?? 0;

    return Scaffold(
      appBar: AppBar(
        title: Text(item['name']), // Item name as the AppBar title
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Item Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(
                item['image'],
                width: double.infinity, // Take full width
                height: 250, // Fixed height for the image
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: double.infinity,
                  height: 250,
                  color: Colors.grey[300],
                  child: Icon(Icons.broken_image, size: 80, color: Colors.grey[600]),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Item Name
            Text(
              item['name'],
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 8),

            // Item Price
            Text(
              item['price'],
              style: TextStyle(
                fontSize: 22,
                color: Colors.teal[700],
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),

            // Item Rating Display (NEW)
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 24), // Larger star icon
                const SizedBox(width: 8),
                Text(
                  '$averageRating', // Average rating
                  style: TextStyle(fontSize: 20, color: Colors.amber.shade800, fontWeight: FontWeight.bold),
                ),
                Text(
                  ' ($numberOfReviews reviews)', // Number of reviews
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                ),
              ],
            ),
            const SizedBox(height: 16),


            // Item Description (Placeholder)
            const Text(
              'This is a detailed description of the item. It would include all relevant information such as condition, dimensions, materials, history, and any special features. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 32),

            // Action Buttons Row (Add to Cart, Wishlist, Options)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Add to Cart Button (now a full button)
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => onAddToCart(item['name']),
                    icon: const Icon(Icons.shopping_cart),
                    label: const Text('Add to Cart'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),

                // Wishlist Icon
                Container(
                  decoration: BoxDecoration(
                    color: Colors.pink.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    onPressed: () => onToggleWishlist(item['name']),
                    icon: Icon(
                      isInWishlist ? Icons.favorite : Icons.favorite_border,
                    ),
                    color: isInWishlist ? Colors.red : Colors.pink,
                    tooltip: isInWishlist ? 'Remove from Wishlist' : 'Add to Wishlist',
                    padding: const EdgeInsets.all(12),
                  ),
                ),
                const SizedBox(width: 8),

                // 3-dot Menu (Favourite and Report)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'favourite_toggle') {
                        onToggleFavourite(item['name']);
                      } else if (value == 'report_item') {
                        _reportItem(context, item['name']);
                      }
                    },
                    itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                      PopupMenuItem<String>(
                        value: 'favourite_toggle',
                        child: Text(isInFavourite ? 'Unfavourite' : 'Favourite'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'report_item',
                        child: Text('Report Item'),
                      ),
                    ],
                    icon: const Icon(Icons.more_vert, color: Colors.grey),
                    tooltip: 'More options',
                    padding: const EdgeInsets.all(12),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
