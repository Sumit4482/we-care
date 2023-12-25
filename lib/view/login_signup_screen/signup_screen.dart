// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:we_care/services/auth_service.dart';
import 'package:we_care/model/user.dart';
import 'package:we_care/view/homescreen/home_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController bloodTypeController = TextEditingController();
  TextEditingController emergencyContactController = TextEditingController();
  String selectedGender = 'Male';
  List<String> bloodTypes = ['A+', 'B+', 'AB+', 'O+', 'A-', 'B-', 'AB-', 'O-'];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Form(
            key: _formKey,
            child: PageView(
              controller: _pageController,
              children: [
                _buildSignupForm(),
                _buildAdditionalFields(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignupForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Email',
              hintText: 'Enter your email',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Email is required';
              }
              // Add your email validation logic here
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Password',
              hintText: 'Enter your password',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Password is required';
              }
              // Add your password validation logic here
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Confirm Password',
              hintText: 'Re-enter your password',
            ),
            validator: (value) {
              if (value != passwordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState?.validate() ?? false) {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              }
            },
            child: const Text('Next'),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Already have an account? "),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Log In',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalFields() {
    String selectedBloodType = 'A+';

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(labelText: 'Name'),
            controller: nameController,
          ),
          const SizedBox(height: 16),
          TextFormField(
            keyboardType: TextInputType.number,
            controller: ageController,
            decoration: const InputDecoration(labelText: 'Age'),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: selectedGender,
            onChanged: (value) {
              setState(() {
                selectedGender = value!;
              });
            },
            items: ['Male', 'Female']
                .map((gender) => DropdownMenuItem(
                      value: gender,
                      child: Text(gender),
                    ))
                .toList(),
            decoration: const InputDecoration(labelText: 'Gender'),
          ),
          const SizedBox(height: 16),
          TextFormField(
            keyboardType: TextInputType.number,
            controller: heightController,
            decoration: const InputDecoration(labelText: 'Height (cm)'),
          ),
          const SizedBox(height: 16),
          TextFormField(
            keyboardType: TextInputType.number,
            controller: weightController,
            decoration: const InputDecoration(labelText: 'Weight (kg)'),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: selectedBloodType,
            onChanged: (value) {
              setState(() {
                selectedBloodType = value!;
              });
            },
            items: bloodTypes
                .map((bloodType) => DropdownMenuItem(
                      value: bloodType,
                      child: Text(bloodType),
                    ))
                .toList(),
            decoration: const InputDecoration(labelText: 'Blood Type'),
          ),
          const SizedBox(height: 16),
          _buildEmergencyContactField(),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState?.validate() ?? false) {
                // Form is valid, perform Firebase signup
                try {
                  // Create a user object with the entered details
                  Userr user = Userr(
                    email: emailController.text,
                    password: passwordController.text,
                    name: nameController.text,
                    age: int.parse(ageController.text),
                    gender: selectedGender,
                    height: double.parse(heightController.text),
                    weight: double.parse(weightController.text),
                    bloodType: selectedBloodType,
                    emergencyContact: emergencyContactController.text,
                  );

                  // Call the signUp method from the AuthService
                  await authService.signUp(user);

                  // Fetch the signed-up user from AuthService
                  User? signedUpUser = await authService.getCurrentUser();

                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(user: signedUpUser),
                    ),
                  );

                  print('User signed up: ${user.email}');
                } catch (e) {
                  print('Error signing up: $e');
                  // Handle signup errors
                }
              }
            },
            child: const Text('Sign Up'),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              _pageController.previousPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
            child: const Text(
              'Back',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyContactField() {
    return TextFormField(
      controller: emergencyContactController,
      decoration: InputDecoration(
        labelText: 'Emergency Contacts',
        suffixIcon: IconButton(
          icon: const Icon(Icons.contacts),
          onPressed: _selectEmergencyContact,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter emergency contacts';
        }
        return null;
      },
    );
  }

  Future<void> _selectEmergencyContact() async {
    // Implement logic to open contacts and select emergency contact
    List<Contact> contacts = await FlutterContacts.getContacts(
      withProperties: true,
      withThumbnail: false,
    );

    // Show a dialog to choose a contact
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Emergency Contact'),
          content: SingleChildScrollView(
            child: Column(
              children: contacts
                  .map((contact) => ListTile(
                        title: Text(contact.displayName),
                        subtitle:
                            Text(_getPhoneNumber(contact) ?? 'No phone number'),
                        onTap: () {
                          // Set the selected contact's name and phone number
                          setState(() {
                            emergencyContactController.text =
                                _getPhoneNumber(contact) ?? '';
                            _formKey.currentState
                                ?.validate(); // Trigger validation
                          });
                          Navigator.of(context).pop(); // Close the dialog
                        },
                      ))
                  .toList(),
            ),
          ),
        );
      },
    );
  }

  String? _getPhoneNumber(Contact contact) {
    if (contact.phones.isNotEmpty == true) {
      // Check if the phone list is not empty
      final List<String?> phoneNumbers =
          contact.phones.map((phone) => phone.number).toList();

      return phoneNumbers.isNotEmpty ? phoneNumbers.first : null;
    }
    return null; // Return null if no phone number is available
  }
}
