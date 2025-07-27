import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'pages/login_page.dart'; // LoginPage for sign-in
import 'pages/register_page.dart'; // RegisterPage for sign-up
import 'pages/home_page.dart'; // HomePage for main navigation

// Make sure you've set up the amplifyconfiguration.dart file
import 'amplifyconfiguration.dart'; // Your Amplify configuration file

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Amplify plugins
  final auth = AmplifyAuthCognito();
  await Amplify.addPlugin(auth);

  // Configure Amplify with the configuration file
  try {
    await Amplify.configure(amplifyconfig);
  } on AmplifyAlreadyConfiguredException {
    print("Amplify is already configured.");
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CommuTrade App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // Set the initial route based on whether the user is authenticated
      initialRoute: '/checkAuth', // This will check the auth status first
      routes: {
        '/checkAuth': (context) => const AuthCheckPage(), // Check auth status first
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const HomePage(), // HomePage is the main entry point
      },
    );
  }
}

// A page that checks if the user is authenticated
class AuthCheckPage extends StatefulWidget {
  const AuthCheckPage({super.key});

  @override
  _AuthCheckPageState createState() => _AuthCheckPageState();
}

class _AuthCheckPageState extends State<AuthCheckPage> {
  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  // Check if user is signed in
  Future<void> _checkAuthStatus() async {
    try {
      final session = await Amplify.Auth.fetchAuthSession();
      if (session.isSignedIn) {
        // If the user is signed in, navigate to the HomePage
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        // Otherwise, navigate to the LoginPage
        Navigator.pushReplacementNamed(context, '/login');
      }
    } catch (e) {
      print("Error fetching auth session: $e");
      Navigator.pushReplacementNamed(context, '/login'); // Default to login if any error occurs
    }
  }

  @override
  Widget build(BuildContext context) {
    // Show a loading indicator while checking auth status
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
