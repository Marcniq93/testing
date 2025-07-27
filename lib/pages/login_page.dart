import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Key for form validation
  final TextEditingController _matricNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false; // State for password visibility toggle
  bool _isLoading = false; // State for loading indicator

  @override
  void dispose() {
    _matricNumberController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Function to handle login logic
  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true; // Show loading indicator
      });

      // Simulate network request delay
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isLoading = false; // Hide loading indicator
      });

      // In a real app, you would send data to your backend here
      // For now, simulate success and navigate
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login successful! Navigating...')),
      );
      Navigator.pushNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          // Apply a linear gradient as the background
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade300,  // Lighter blue at the top
              Colors.blue.shade700,  // Darker blue at the bottom
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form( // Wrap inputs in a Form for validation
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction, // Validate on user interaction
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.storefront,
                    size: 80,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'CommuTrade', // App name updated
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Matric Number input field
                  TextFormField( // Changed to TextFormField for validation
                    controller: _matricNumberController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration( // No longer const due to dynamic focusedBorder
                      labelText: 'Matric Number',
                      labelStyle: const TextStyle(color: Colors.white70), // Slightly less opaque for label
                      prefixIcon: const Icon(Icons.badge, color: Colors.white),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.15), // Improved contrast
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10), // Rounded corners for input fields
                        borderSide: BorderSide.none, // No border by default
                      ),
                      focusedBorder: OutlineInputBorder( // Highlight when focused
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.white, width: 2.0), // White border when focused
                      ),
                      enabledBorder: OutlineInputBorder( // Default border
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white.withOpacity(0.5), width: 1.0), // Subtle white border
                      ),
                      errorStyle: const TextStyle(color: Colors.redAccent), // Style for error text
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Matric Number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  // Password input field
                  TextFormField( // Changed to TextFormField for validation
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible, // Use state for visibility
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration( // No longer const due to dynamic focusedBorder and suffixIcon
                      labelText: 'Password',
                      labelStyle: const TextStyle(color: Colors.white70),
                      prefixIcon: const Icon(Icons.lock, color: Colors.white),
                      suffixIcon: IconButton( // Password visibility toggle
                        icon: Icon(
                          _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.15), // Improved contrast
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10), // Rounded corners for input fields
                        borderSide: BorderSide.none, // No border by default
                      ),
                      focusedBorder: OutlineInputBorder( // Highlight when focused
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.white, width: 2.0), // White border when focused
                      ),
                      enabledBorder: OutlineInputBorder( // Default border
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white.withOpacity(0.5), width: 1.0), // Subtle white border
                      ),
                      errorStyle: const TextStyle(color: Colors.redAccent), // Style for error text
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) { // Example: minimum password length
                        return 'Password must be at least 6 characters long';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  // Login button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _login, // Disable button while loading
                      style: ElevatedButton.styleFrom( // Use ElevatedButton.styleFrom for modern styling
                        backgroundColor: Colors.teal,
                        foregroundColor: Colors.white, // Text color
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 5,
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white) // Loading indicator
                          : const Text(
                        'Login',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Register button
                  TextButton(
                    onPressed: _isLoading ? null : () { // Disable button while loading
                      Navigator.pushNamed(context, '/register');
                    },
                    child: const Text(
                      "Don't have an account? Register",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
