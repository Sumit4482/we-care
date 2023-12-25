// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:we_care/view/health_tips/healthtips.dart';
import 'package:we_care/view/login_signup_screen/login_screen.dart';
import 'package:we_care/view/medicine_reminder/medicine_reminder.dart';

class HomeScreen extends StatelessWidget {
  final User? user;

  const HomeScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<String>(
          future: _loadUserName(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Loadning'); // Placeholder while loading
            } else if (snapshot.hasError) {
              return const Text('Hello'); // Placeholder for error handling
            } else {
              return Text('Hello ${snapshot.data}');
            }
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              // Handle logout here
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) => _buildCard(index + 1, context),
        ),
      ),
    );
  }

  Future<String> _loadUserName() async {
    try {
      // Fetch user document from Firestore using the UID
      DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(user?.uid)
          .get();

      // Access the 'name' field from the document
      return userDoc.get('name') ?? '';
    } catch (e) {
      print('Error loading user name: $e');
      return ''; // Return an empty string in case of an error
    }
  }

  Widget _buildCard(int cardNumber, BuildContext context) {
    Widget card;
    if (cardNumber == 1) {
      card = _buildHealthTipsCard(context);
    } else if (cardNumber == 2) {
      card = _buildMedicineReminderCard(context);
    } else if (cardNumber == 3) {
      card = _buildSOSCard();
    } else {
      card = Card(
        color: Colors.teal,
        child: ListTile(
          title: Text(
            'Card $cardNumber',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: AspectRatio(
        aspectRatio: 1.9, // Adjust this ratio as needed
        child: card,
      ),
    );
  }

  Widget _buildHealthTipsCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the HealthTips screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HealthTipsScreen()),
        );
      },
      child: const Card(
        color: Colors.green, // You can customize the color as needed
        child: ListTile(
          title: Text(
            'Health Tips',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMedicineReminderCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the MedicineReminder screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MedicineReminderScreen()),
        );
      },
      child: const Card(
        color: Colors.blue, // You can customize the color as needed
        child: ListTile(
          title: Text(
            'Medicine Reminder',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSOSCard() {
    return Card(
      color: Colors.red, // You can customize the color as needed
      child: ListTile(
        title: Container(
          alignment: Alignment.center,
          child: ElevatedButton(
            onPressed: () {
              // Handle SOS button click
              _handleSOSClick();
            },
            child: const Text(
              'SOS',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleSOSClick() async {
    // ... (unchanged)
  }
}
