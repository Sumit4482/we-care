import 'dart:math';

import 'package:flutter/material.dart';
import 'package:we_care/model/tips.dart';

class HealthTipsScreen extends StatefulWidget {
  const HealthTipsScreen({super.key});

  @override
  _HealthTipsScreenState createState() => _HealthTipsScreenState();
}

class _HealthTipsScreenState extends State<HealthTipsScreen> {
  int currentTipIndex = 0;

  void refreshTip() {
    setState(() {
      currentTipIndex = Random().nextInt(HealthTips.tips.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Tips'),
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(16.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  HealthTips.tips[currentTipIndex],
                  style: const TextStyle(fontSize: 18.0),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: refreshTip,
                  child: const Text('Refresh Tip'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
