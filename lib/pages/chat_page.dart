import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    // We are removing the AppBar from this Scaffold.
    // The main AppBar is handled by HomePage, which now dynamically
    // updates its title based on the selected tab.
    return const Scaffold( // Removed 'appBar' property
      body: Center(
        child: Text(
          'Your Chats will be here!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

