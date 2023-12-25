// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:we_care/view/login_signup_screen/login_screen.dart';
import 'package:we_care/view/login_signup_screen/signup_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> get _pages => [
        const OnboardingPage(
          path: "assets/p1.png",
          title: 'Welcome to We Care!',
          description: 'Empowering the golden years with technology',
        ),
        const OnboardingPage(
          path: "assets/p2.png",
          title: 'Never Miss a Dose',
          description: 'Personalized medicine reminders tailored just for you.',
        ),
        OnboardingPageWithButtons(
          path: "assets/p3.png",
          title: 'Wellness Tips Every Day',
          description:
              'Access a wealth of daily health tips to boost your well-being.',
          onLoginPressed: () {
            _navigateToLogin();
          },
          onSignupPressed: () {
            _navigateToSignup();
          },
        ),
      ];

  void _navigateToLogin() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  void _navigateToSignup() {
    // Navigate to the signup screen
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const SignupScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return _pages[index];
            },
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildPageIndicator(),
            ),
          ),
          Positioned(
            top: 30,
            right: 20,
            child: TextButton(
              onPressed: () {
                _pageController.animateToPage(
                  2,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              child: Container(
                width: 60,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                ),
                child: const Center(
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < _pages.length; i++) {
      indicators.add(
        Container(
          width: 10,
          height: 10,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: i == _currentPage ? Colors.blue : Colors.grey,
          ),
        ),
      );
    }
    return indicators;
  }
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String path;

  const OnboardingPage({
    Key? key,
    required this.title,
    required this.description,
    required this.path,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 30),
          Container(
            width: 100,
            height: 100,
            child: Image.asset(path),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class OnboardingPageWithButtons extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onLoginPressed;
  final VoidCallback onSignupPressed;
  final String path;

  const OnboardingPageWithButtons({
    Key? key,
    required this.title,
    required this.description,
    required this.onLoginPressed,
    required this.onSignupPressed,
    required this.path,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 30),
          Container(width: 100, height: 100, child: Image.asset(path)),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: onLoginPressed,
                child: const Text('Login'),
              ),
              ElevatedButton(
                onPressed: onSignupPressed,
                child: const Text('Signup'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
