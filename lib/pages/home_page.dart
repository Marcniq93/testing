import 'package:flutter/material.dart';
import 'chat_page.dart';
import 'marketplace_page.dart';
import 'profile_page.dart';
import 'wishlist_page.dart'; // Import the wishlist page
import 'favourites_page.dart'; // Import the favourites page
import 'cart_page.dart'; // Import the cart page
import 'item_page.dart'; // Import item_page.dart for Recommended items (optional, if navigating)

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  bool _isSearching = false; // State to control search bar visibility in AppBar
  final TextEditingController _searchController = TextEditingController(); // Controller for search input

  // State lifted up to HomePage for Wishlist, Favourites, and Cart
  final Set<String> _wishlistItems = {};
  final Set<String> _favouriteItems = {};
  final Set<String> _cartItems = {}; // State for items in the cart

  // List of titles corresponding to each page
  final List<String> _pageTitles = [
    "Home",
    "Chats",
    "Marketplace",
    "Profile",
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // Reset search state when navigating away from Marketplace
      if (_isSearching && _selectedIndex != 2) {
        _isSearching = false;
        _searchController.clear();
        FocusScope.of(context).unfocus();
      }
    });
  }

  // Toggles the search bar visibility in the AppBar
  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchController.clear();
        FocusScope.of(context).unfocus();
      }
    });
  }

  // Callback for MarketplacePage to update wishlist state
  void _onToggleWishlist(String itemName) {
    setState(() {
      if (_wishlistItems.contains(itemName)) {
        _wishlistItems.remove(itemName);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$itemName removed from wishlist!')),
        );
      } else {
        _wishlistItems.add(itemName);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$itemName added to wishlist!')),
        );
      }
    });
  }

  // Callback for MarketplacePage to update favourite state
  void _onToggleFavourite(String itemName) {
    setState(() {
      if (_favouriteItems.contains(itemName)) {
        _favouriteItems.remove(itemName);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$itemName removed from favourites!')),
        );
      } else {
        _favouriteItems.add(itemName);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$itemName added to favourites!')),
        );
      }
    });
  }

  // Callback for MarketplacePage to add item to cart
  void _onAddToCart(String itemName) {
    setState(() {
      if (!_cartItems.contains(itemName)) { // Prevent adding same item multiple times for simplicity
        _cartItems.add(itemName);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$itemName added to cart! Total items: ${_cartItems.length}')),
        );
        print('$itemName added to cart! Current cart: $_cartItems');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$itemName is already in your cart.')),
        );
      }
    });
  }

  // Method to show filter options (called from AppBar)
  void _showFilterOptions() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Filter Options'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Category'),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: const Text('Price Range'),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: const Text('Condition'),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // List of pages for bottom navigation, now passing state and callbacks to MarketplacePage
    final List<Widget> pages = [
      // Home content now includes recent activity and recommended items
      _HomeContent(
        notifications: const [
          {'sender': 'Admin', 'message': 'Welcome to CommuTrade!', 'chatId': 'admin_welcome'},
          {'sender': 'User A', 'message': 'Interested in your textbook!', 'chatId': 'chat_a'},
        ],
        addNotification: (notification) {}, // Placeholder
        onNotificationTap: (chatId) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Tapped notification for chat: $chatId')),
          );
          // In a real app, navigate to the specific chat
        },
        onAddToCart: _onAddToCart, // Pass onAddToCart to HomeContent for recommended items
        onToggleWishlist: _onToggleWishlist, // Pass wishlist toggle
        onToggleFavourite: _onToggleFavourite, // Pass favourite toggle
        wishlistItems: _wishlistItems,
        favouriteItems: _favouriteItems,
      ),
      const ChatPage(),
      // MarketplacePage now receives state and callbacks, including onAddToCart
      MarketplacePage(
        wishlistItems: _wishlistItems,
        favouriteItems: _favouriteItems,
        onToggleWishlist: _onToggleWishlist,
        onToggleFavourite: _onToggleFavourite,
        onAddToCart: _onAddToCart, // Pass the onAddToCart callback
      ),
      const ProfilePage(),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        automaticallyImplyLeading: false, // Remove back button

        // Dynamic Title/Search Bar
        title: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
          child: _selectedIndex == 2 && _isSearching // Show search field if on Marketplace and searching
              ? TextField(
            key: const ValueKey<int>(1), // Unique key for AnimatedSwitcher
            controller: _searchController,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'Search marketplace...',
              hintStyle: TextStyle(color: Colors.white70),
              border: InputBorder.none,
            ),
            style: const TextStyle(color: Colors.white, fontSize: 18),
            cursorColor: Colors.white,
            onSubmitted: (query) {
              print('Search submitted from AppBar: $query');
              // Implement search logic here (e.g., filter MarketplacePage items)
            },
          )
              : Text(
            _pageTitles[_selectedIndex], // Show regular page title
            key: const ValueKey<int>(0), // Unique key for AnimatedSwitcher
            style: const TextStyle(color: Colors.white),
          ),
        ),

        // Dynamic Actions (Search, Filter, 3-dot menu)
        actions: [
          if (_selectedIndex == 2) // Only show these actions on Marketplace tab
          // Search icon / Close search icon
            IconButton(
              icon: Icon(_isSearching ? Icons.close : Icons.search, color: Colors.white),
              onPressed: _toggleSearch,
              tooltip: _isSearching ? 'Close Search' : 'Search',
            ),
          if (_selectedIndex == 2 && !_isSearching) // Only show filter icon when not searching
          // Filter icon
            Container(
              decoration: BoxDecoration(
                color: Colors.teal, // Background color for the filter icon
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                icon: const Icon(Icons.filter_list, color: Colors.white),
                onPressed: _showFilterOptions,
                tooltip: 'Filter',
              ),
            ),
          // Cart icon with item count in the AppBar - MOVED TO BE BEFORE POPUPMENU BUTTON
          if (_selectedIndex == 2 && !_isSearching) // Only show cart icon on Marketplace when not searching
            Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart, color: Colors.white),
                  onPressed: () {
                    // Navigate to the CartPage when the cart icon is tapped
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartPage(cartItems: _cartItems.toList()),
                      ),
                    );
                  },
                  tooltip: 'View Cart',
                ),
                if (_cartItems.isNotEmpty)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        '${_cartItems.length}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
              ],
            ),
          if (_selectedIndex == 2 && !_isSearching) // Only show 3-dot menu when not searching
          // 3-dot menu for Wishlist/Favourites views
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'wishlist') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WishlistPage(wishlistItems: _wishlistItems.toList()),
                    ),
                  );
                } else if (value == 'favourites') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FavouritesPage(favouriteItems: _favouriteItems.toList()),
                    ),
                  );
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'wishlist',
                  child: Text('View Wishlist'),
                ),
                const PopupMenuItem<String>(
                  value: 'favourites',
                  child: Text('View Favourites'),
                ),
              ],
              icon: const Icon(Icons.more_vert, color: Colors.white),
              tooltip: 'More options',
            ),
        ],
      ),
      body: GestureDetector( // Added GestureDetector for swipe navigation
        onHorizontalDragEnd: (details) {
          // Determine swipe direction and navigate
          // Swiping left (positive velocity) means going to the next tab
          if (details.primaryVelocity! < 0) {
            if (_selectedIndex < pages.length - 1) {
              _onItemTapped(_selectedIndex + 1);
            }
          }
          // Swiping right (negative velocity) means going to the previous tab
          else if (details.primaryVelocity! > 0) {
            if (_selectedIndex > 0) {
              _onItemTapped(_selectedIndex - 1);
            }
          }
        },
        child: pages[_selectedIndex], // Display selected page content
      ),
      floatingActionButton: _selectedIndex == 0 // Only show FAB on Home page for demonstration
          ? FloatingActionButton(
        onPressed: () {
          // This is a placeholder for adding notifications
          // You'll need to update _HomeContent to accept a callback for this
          // For now, it will just print.
          print("Add button pressed on Home page!");
        },
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add, size: 32),
        tooltip: 'Add New Item',
      )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 6,
        elevation: 10,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home, "Home", 0),
              _buildNavItem(Icons.chat, "Chats", 1),
              const SizedBox(width: 40), // For the floating button
              _buildNavItem(Icons.store, "Marketplace", 2),
              _buildNavItem(Icons.person, "Profile", 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: isSelected ? Colors.teal : Colors.grey),
          Text(label, style: TextStyle(color: isSelected ? Colors.teal : Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }
}

// Separate Widget for Home Page content to display notifications, recent activity, and recommended items
class _HomeContent extends StatelessWidget {
  final List<Map<String, String>> notifications;
  final Function(Map<String, String>) addNotification;
  final Function(String) onNotificationTap;
  final Function(String) onAddToCart; // Needed for recommended items
  final Function(String) onToggleWishlist; // Needed for recommended items
  final Function(String) onToggleFavourite; // Needed for recommended items
  final Set<String> wishlistItems;
  final Set<String> favouriteItems;

  const _HomeContent({
    required this.notifications,
    required this.addNotification,
    required this.onNotificationTap,
    required this.onAddToCart,
    required this.onToggleWishlist,
    required this.onToggleFavourite,
    required this.wishlistItems,
    required this.favouriteItems,
  });

  // Dummy list of recommended items for demonstration
  static const List<Map<String, dynamic>> _recommendedItems = [
    {'name': 'Recommended Item A', 'price': 'RM 00.00', 'image': 'https://placehold.co/80x80/D1FAE5/065F46?text=Rec+A', 'description': 'A recommended item placeholder.', 'condition': 'Condition', 'averageRating': 4.0, 'numberOfReviews': 50},
    {'name': 'Recommended Item B', 'price': 'RM 00.00', 'image': 'https://placehold.co/80x80/FFDDC1/E65100?text=Rec+B', 'description': 'Another recommended item placeholder.', 'condition': 'Condition', 'averageRating': 4.2, 'numberOfReviews': 30},
    {'name': 'Recommended Item C', 'price': 'RM 00.00', 'image': 'https://placehold.co/80x80/C8E6C9/2E7D32?text=Rec+C', 'description': 'A third recommended item placeholder.', 'condition': 'Condition', 'averageRating': 3.5, 'numberOfReviews': 10},
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Notifications Section
          const Text(
            'Notifications',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal),
          ),
          const SizedBox(height: 12),
          notifications.isEmpty
              ? const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                "No new notifications. Check back later!",
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ),
          )
              : ListView.builder(
            shrinkWrap: true, // Important for nested ListView in SingleChildScrollView
            physics: const NeverScrollableScrollPhysics(), // Disable scrolling for this nested list
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification = notifications[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 10.0),
                elevation: 1,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                child: ListTile(
                  leading: const Icon(Icons.info_outline, color: Colors.blueGrey),
                  title: Text(notification['sender']!),
                  subtitle: Text(notification['message']!, maxLines: 1, overflow: TextOverflow.ellipsis),
                  onTap: () => onNotificationTap(notification['chatId']!),
                ),
              );
            },
          ),
          const SizedBox(height: 24),

          // Recent Activity Section
          const Text(
            'Recent Activity',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal),
          ),
          const SizedBox(height: 12),
          // Placeholder for recent activity list
          Column(
            children: [
              _buildActivityTile(context, 'You received a message about "Placeholder Item 1".', Icons.chat),
              _buildActivityTile(context, 'Your listing "Placeholder Item 3" was viewed.', Icons.visibility),
            ],
          ),
          const SizedBox(height: 24),

          // Recommended for You Section
          const Text(
            'Recommended for You',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 200, // Fixed height for horizontal scroll view
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _recommendedItems.length,
              itemBuilder: (context, index) {
                final item = _recommendedItems[index];
                final bool isInWishlist = wishlistItems.contains(item['name']);
                final bool isInFavourite = favouriteItems.contains(item['name']);

                return GestureDetector(
                  onTap: () {
                    // Navigate to ItemDetailPage when recommended item is tapped
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ItemDetailPage(
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
                  child: Container(
                    width: 150, // Fixed width for each recommended item card
                    margin: const EdgeInsets.only(right: 16),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                item['image'],
                                height: 80,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => Center(
                                  child: Icon(Icons.image, size: 40, color: Colors.grey[400]),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              item['name'],
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item['price'],
                              style: TextStyle(color: Colors.green.shade700, fontWeight: FontWeight.bold, fontSize: 13),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(Icons.star, color: Colors.amber, size: 12),
                                const SizedBox(width: 4),
                                Text(
                                  '${item['averageRating']}',
                                  style: TextStyle(fontSize: 11, color: Colors.amber.shade800),
                                ),
                                Text(
                                  ' (${item['numberOfReviews']})',
                                  style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
                                ),
                              ],
                            ),
                          ],
                        ),
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

  Widget _buildActivityTile(BuildContext context, String text, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10.0),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        leading: Icon(icon, color: Colors.teal),
        title: Text(text),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Tapped activity: $text')),
          );
        },
      ),
    );
  }
}
