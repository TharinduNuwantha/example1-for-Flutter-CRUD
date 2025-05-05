import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditEmployee extends StatefulWidget {
  final String id;
  final String name;
  final String age;
  final String location;

  const EditEmployee({
    super.key,
    required this.id,
    required this.name,
    required this.age,
    required this.location,
  });

  @override
  State<EditEmployee> createState() => _EditEmployeeState();
}

class _EditEmployeeState extends State<EditEmployee> {
  late TextEditingController nameController;
  late TextEditingController ageController;
  late TextEditingController locationController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    ageController = TextEditingController(text: widget.age);
    locationController = TextEditingController(text: widget.location);
  }

  Future<void> updateEmployee() async {
    Map<String, dynamic> updatedData = {
      "Name": nameController.text,
      "Age": ageController.text,
      "Location": locationController.text,
      "Id": widget.id,
    };

    await FirebaseFirestore.instance
        .collection("Employee")
        .doc(widget.id)
        .update(updatedData);

    Fluttertoast.showToast(
        msg: "Employee updated successfully",
        backgroundColor: Colors.green,
        textColor: Colors.white);

    Navigator.pop(context); // go back after update
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Employee"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: ageController,
              decoration: const InputDecoration(labelText: "Age"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: locationController,
              decoration: const InputDecoration(labelText: "Location"),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: updateEmployee,
              child: const Text("Update"),
            )
          ],
        ),
      ),
    );
  }
}
