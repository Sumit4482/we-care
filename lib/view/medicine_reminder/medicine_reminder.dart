import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_care/model/medicine.dart';

class MedicineReminderScreen extends StatefulWidget {
  const MedicineReminderScreen({super.key});

  @override
  _MedicineReminderScreenState createState() => _MedicineReminderScreenState();
}

class _MedicineReminderScreenState extends State<MedicineReminderScreen> {
  List<Medicine> medicines = [];

  @override
  void initState() {
    super.initState();
    // Load medicines from shared preferences when the widget is created
    loadMedicines();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medicine Reminder'),
      ),
      body: ListView.builder(
        itemCount: medicines.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(
                medicines[index].name), // Use a unique key for each medicine
            onDismissed: (direction) {
              // Remove the dismissed medicine from the list
              setState(() {
                medicines.removeAt(index);
                // Save updated medicines to shared preferences
                saveMedicines();
              });
            },
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 16.0),
              child: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            child: ListTile(
              title: Text(medicines[index].name),
              subtitle: Text('Take at: ${medicines[index].time}'),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddMedicineScreen()),
          );

          if (result != null && result is Medicine) {
            setState(() {
              medicines.add(result);
              // Save updated medicines to shared preferences
              saveMedicines();
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  // Load medicines from shared preferences
  Future<void> loadMedicines() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? medicineList = prefs.getStringList('medicines');

    if (medicineList != null) {
      setState(() {
        medicines = medicineList
            .map((json) => Medicine.fromJson(jsonDecode(json)))
            .toList();
      });
    }
  }

  // Save medicines to shared preferences
  Future<void> saveMedicines() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> medicineList =
        medicines.map((medicine) => jsonEncode(medicine.toJson())).toList();
    prefs.setStringList('medicines', medicineList);
  }
}

class AddMedicineScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  AddMedicineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Medicine'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Medicine Name'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: timeController,
              decoration: const InputDecoration(labelText: 'Reminder Time'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Medicine newMedicine = Medicine(
                  name: nameController.text,
                  time: timeController.text,
                );

                Navigator.pop(context, newMedicine);
              },
              child: const Text('Add Medicine'),
            ),
          ],
        ),
      ),
    );
  }
}
