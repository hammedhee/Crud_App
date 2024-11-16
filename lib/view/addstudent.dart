import 'dart:io';

import 'package:crud_app/functions/functions.dart';
import 'package:crud_app/model/student.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Addstudent extends StatefulWidget {
  const Addstudent({super.key});

  @override
  State<Addstudent> createState() => _AddstudentState();
}

class _AddstudentState extends State<Addstudent> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _clsController = TextEditingController();
  final _addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  File? _selectImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Add Student',
          style: TextStyle(color: Colors.amber),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: CircleAvatar(
                  radius: 55,
                  backgroundColor: const Color.fromARGB(200, 255, 255, 255),
                  backgroundImage: _selectImage != null
                      ? FileImage(_selectImage!)
                      : const AssetImage('assets/student.jpg') as ImageProvider,
                )),
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                onPressed: () {
                  _pickImageGallery();
                },
                label: const Text(
                  'Gallery',
                  style: TextStyle(color: Colors.black),
                ),
                icon: const Icon(
                  Icons.image,
                  color: Colors.black,
                )),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your name';
                        } else {
                          return null;
                        }
                      },
                      controller: _nameController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          labelText: 'Name',
                          labelStyle: const TextStyle(color: Colors.amber),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50))),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your age';
                        } else {
                          return null;
                        }
                      },
                      controller: _ageController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          labelText: 'Age',
                          labelStyle: const TextStyle(color: Colors.amber),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50))),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your class';
                        } else {
                          return null;
                        }
                      },
                      controller: _clsController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          labelText: 'Class',
                          labelStyle: const TextStyle(color: Colors.amber),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50))),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your address';
                        } else {
                          return null;
                        }
                      },
                      controller: _addressController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          labelText: 'Address',
                          labelStyle: const TextStyle(color: Colors.amber),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50))),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          onAddStudentBtn();
                          Navigator.pop(context);
                        }
                      },
                      child: const Icon(
                        Icons.person_add_alt,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> onAddStudentBtn() async {
    final name = _nameController.text;
    final age = _ageController.text;
    final cls = _clsController.text;
    final address = _addressController.text;
    if (name.isEmpty || age.isEmpty || cls.isEmpty || address.isEmpty) {
      return;
    }
    final student = Student(
        name: name,
        age: age,
        cls: cls,
        address: address,
        imagePath: _selectImage?.path ?? "");
    addStudent(student);
  }

  Future _pickImageGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      return;
    } else {
      setState(() {
        _selectImage = File(pickedFile.path);
      });
    }
  }
}
