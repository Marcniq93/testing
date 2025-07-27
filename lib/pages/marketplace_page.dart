import 'package:flutter/material.dart';
// Ensure these imports match your actual file names and class names
import 'wishlist_page.dart';
import 'favourites_page.dart';
import 'item_page.dart'; // Corrected import to match your file name

class MarketplacePage extends StatelessWidget {
  // Receive state and callbacks from HomePage
  final Set<String> wishlistItems;
  final Set<String> favouriteItems;
  final Function(String) onToggleWishlist;
  final Function(String) onToggleFavourite;
  final Function(String) onAddToCart;

  const MarketplacePage({
    super.key,
    required this.wishlistItems,
    required this.favouriteItems,
    required this.onToggleWishlist,
    required this.onToggleFavourite,
    required this.onAddToCart,
  });

  // Dummy list of marketplace items for demonstration
  // All fields are now generic placeholders, including new rating fields
  static const List<Map<String, dynamic>> _marketplaceItems = [
    {'name': 'Placeholder Item 1', 'price': 'RM 00.00', 'image': 'https://placehold.co/100x100/A7F3D0/065F46?text=Item+1', 'description': 'Insert description here for Placeholder Item 1. This text will be replaced by backend data.', 'condition': 'Condition', 'averageRating': 4.5, 'numberOfReviews': 120},
    {'name': 'Placeholder Item 2', 'price': 'RM 00.00', 'image': 'https://placehold.co/100x100/FECACA/991B1B?text=Item+2', 'description': 'Insert description here for Placeholder Item 2. This text will be replaced by backend data.', 'condition': 'Condition', 'averageRating': 3.8, 'numberOfReviews': 45},
    {'name': 'Placeholder Item 3', 'price': 'RM 00.00', 'image': 'https://placehold.co/100x100/BFDBFE/1E40AF?text=Item+3', 'description': 'Insert description here for Placeholder Item 3. This text will be replaced by backend data.', 'condition': 'Condition', 'averageRating': 5.0, 'numberOfReviews': 8},
    {'name': 'Placeholder Item 4', 'price': 'RM 00.00', 'image': 'https://placehold.co/100x100/FEE2E2/991B1B?text=Item+4', 'description': 'Insert description here for Placeholder Item 4. This text will be replaced by backend data.', 'condition': 'Condition', 'averageRating': 4.2, 'numberOfReviews': 76},
    {'name': 'Placeholder Item 5', 'price': 'RM 00.00', 'image': 'https://placehold.co/100x100/D1FAE5/065F46?text=Item+5', 'description': 'Insert description here for Placeholder Item 5. This text will be replaced by backend data.', 'condition': 'Condition', 'averageRating': 2.9, 'numberOfReviews': 15},
    {'name': 'Placeholder Item 6', 'price': 'RM 00.00', 'image': 'https://placehold.co/100x100/FFDDC1/E65100?text=Item+6', 'description': 'Insert description here for Placeholder Item 6. This text will be replaced by backend data.', 'condition': 'Condition', 'averageRating': 4.7, 'numberOfReviews': 203},
    {'name': 'Placeholder Item 7', 'price': 'RM 00.00', 'image': 'https://placehold.co/100x100/C8E6C9/2E7D32?text=Item+7', 'description': 'Insert description here for Placeholder Item 7. This text will be replaced by backend data.', 'condition': 'Condition', 'averageRating': 4.0, 'numberOfReviews': 98},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.fromLTRB(
                16.0,
                0.0,
                16.0,
                MediaQuery.of(context).padding.bottom + 80.0,
              ),
              itemCount: _marketplaceItems.length,
              itemBuilder: (context, index) {
                final item = _marketplaceItems[index];
                final bool isInWishlist = wishlistItems.contains(item['name']);
                final bool isInFavourite = favouriteItems.contains(item['name']);

                // Determine tag color based on condition (now generic 'Condition')
                Color tagColor = Colors.grey.shade100;
                Color tagTextColor = Colors.grey.shade800;
                // You can add more specific conditions here if needed,
                // e.g., if you have 'New', 'Used', 'Refurbished' as backend options
                // For now, it defaults to grey as it's a generic placeholder
                if (item['condition'] == 'Used') { // Example for future dynamic usage
                  tagColor = Colors.orange.shade100;
                  tagTextColor = Colors.orange.shade800;
                } else if (item['condition'] == 'New') { // Example for future dynamic usage
                  tagColor = Colors.green.shade100;
                  tagTextColor = Colors.green.shade800;
                }


                return Card(
                  margin: const EdgeInsets.only(bottom: 16.0),
                  elevation: 6, // Slightly higher elevation for a modern feel
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)), // More rounded corners
                  child: InkWell( // Use InkWell for tap detection on the whole card
                    onTap: () {
                      // Navigate to ItemDetailPage when the card is tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ItemDetailPage( // Use ItemDetailPage as the class name
                            item: item,
                            isInWishlist: isInWishlist,
                            isInFavourite: isInFavourite,
                            onToggleWishlist: onToggleWishlist,
                            onToggleFavourite: onToggleFavourite,
                            onAddToCart: onAddToCart,
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Item Image
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.grey[200], // Light background for image area
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.network(
                                item['image'],
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => Center(
                                  child: Icon(Icons.image, size: 50, color: Colors.grey[600]), // Generic image icon
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Item Name
                                Text(
                                  item['name'],
                                  style: const TextStyle(
                                    fontSize: 19, // Slightly larger for readability
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 6),

                                // Item Price - More prominent
                                Text(
                                  item['price'],
                                  style: TextStyle(
                                    fontSize: 18, // Larger price
                                    color: Colors.green.shade700, // Green for price (suggests good deal)
                                    fontWeight: FontWeight.w800, // Extra bold
                                  ),
                                ),
                                const SizedBox(height: 8),

                                // Item Description (truncated)
                                Text(
                                  item['description'],
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                  maxLines: 2, // Limit to 2 lines
                                  overflow: TextOverflow.ellipsis, // Add ellipsis if too long
                                ),
                                const SizedBox(height: 8), // Spacing below description

                                // Row for Condition Tag and Rating
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between tag and rating
                                  children: [
                                    // Dynamic Condition Tag
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: tagColor, // Dynamic background color
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Text(
                                        item['condition'], // Display the actual condition
                                        style: TextStyle(fontSize: 12, color: tagTextColor), // Dynamic text color
                                      ),
                                    ),
                                    // Item Rating Display
                                    Row(
                                      children: [
                                        Icon(Icons.star, color: Colors.amber, size: 16), // Star icon
                                        const SizedBox(width: 4),
                                        Text(
                                          '${item['averageRating']}', // Average rating
                                          style: TextStyle(fontSize: 14, color: Colors.amber.shade800, fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          ' (${item['numberOfReviews']})', // Number of reviews
                                          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
