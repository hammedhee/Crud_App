import 'dart:io';

import 'package:crud_app/functions/functions.dart';
import 'package:crud_app/model/student.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class EditStudent extends StatefulWidget {
  String name;
  String age;
  String cls;
  String address;
  int index;
  dynamic imagePath;

  EditStudent(
      {super.key,
      required this.name,
      required this.age,
      required this.cls,
      required this.address,
      required this.index,
      required this.imagePath});

  @override
  State<EditStudent> createState() => _EditStudentState();
}

class _EditStudentState extends State<EditStudent> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _clsController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  File? _slctImg;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.name;
    _ageController.text = widget.age;
    _clsController.text = widget.cls;
    _addressController.text = widget.address;
    _slctImg = widget.imagePath != '' ? File(widget.imagePath) : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(backgroundColor: Colors.black,
      centerTitle: true,
        title: const Text('Edit Student',style: TextStyle(color: Colors.amber),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: 55,
                backgroundImage: _slctImg != null
                    ? FileImage(_slctImg!)
                    : const AssetImage('assets/download.jpeg') as ImageProvider,
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                  onPressed: () {
                    _pickImageGllry();
                  },
                  label:  Text('Gallery',style:TextStyle(color: Colors.black) ,),
                  icon: const Icon(Icons.image,color: Colors.black,)),
              const SizedBox(height: 40),
              TextField(
                controller: _nameController,
                style: const TextStyle(color: Colors.white),
                decoration:  InputDecoration(
                  labelText: 'Name',labelStyle: TextStyle(color: Colors.amber),
                  contentPadding: EdgeInsets.all(10),
                  fillColor: Color.fromARGB(255, 0, 0, 0),
                  filled: true,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _ageController,
                style: const TextStyle(color: Colors.white),
                decoration:  InputDecoration(
                  labelText: 'Age',labelStyle: TextStyle(color: Colors.amber),
                  contentPadding: EdgeInsets.all(10),
                  fillColor: Color.fromARGB(255, 0, 0, 0),
                  filled: true,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _clsController,
                style: const TextStyle(color: Colors.white),
                decoration:  InputDecoration(
                  labelText: 'Class',labelStyle: TextStyle(color: Colors.amber),
                  contentPadding: EdgeInsets.all(10),
                  fillColor: Color.fromARGB(255, 0, 0, 0),
                  filled: true,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _addressController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                     labelText: 'Address',labelStyle: TextStyle(color: Colors.amber),
                  contentPadding: EdgeInsets.all(10),
                  fillColor: Color.fromARGB(255, 0, 0, 0),
                  filled: true,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber,),
                onPressed: () {
                  updateAll();
                  Navigator.pop(context);
                },
                child: const Text('Update',style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),),
                
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> updateAll() async {
    final namee = _nameController.text;
    final agee = _ageController.text;
    final classe = _clsController.text;
    final addresse = _addressController.text;
    final Image1 = _slctImg?.path ?? "";

    if (namee.isEmpty || agee.isEmpty || classe.isEmpty || addresse.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill all fields')));
    } else {
      final update = Student(
          name: namee,
          age: agee,
          cls: classe,
          address: addresse,
          imagePath: Image1);
      editing(widget.index, update);
    }
  }

  Future _pickImageGllry() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _slctImg = File(pickedFile.path);
      });
    }
  }
}
