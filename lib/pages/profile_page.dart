import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // This page does not have its own AppBar, as it is managed by HomePage.
    return Scaffold(
      body: Center(
        child: SingleChildScrollView( // Added SingleChildScrollView for smaller screens
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Profile Picture
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[300], // Placeholder background color
                  border: Border.all(color: Colors.teal, width: 4), // Border around the profile picture
                ),
                child: ClipOval(
                  child: Image.network(
                    'https://placehold.co/120x120/E0F2F1/004D40?text=P', // Placeholder image
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.person,
                      size: 80,
                      color: Colors.teal[800], // Icon color
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // User Name
              const Text(
                'John Doe', // Placeholder for user's name
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),

              // Matric Number
              const Text(
                'Matric Number: 12345678', // Placeholder for matric number
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 32),

              // Edit Profile Button
              SizedBox(
                width: double.infinity, // Make button take full width
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Implement profile editing logic
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Edit Profile clicked!')),
                    );
                  },
                  icon: const Icon(Icons.edit, color: Colors.white),
                  label: const Text(
                    'Edit Profile',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Logout Button
              SizedBox(
                width: double.infinity, // Make button take full width
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Implement logout logic
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Logout clicked!')),
                    );
                    // In a real app, you would navigate back to the login screen:
                    // Navigator.pushReplacementNamed(context, '/login');
                  },
                  icon: const Icon(Icons.logout, color: Colors.white),
                  label: const Text(
                    'Logout',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade700,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
