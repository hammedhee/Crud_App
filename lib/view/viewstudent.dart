import 'dart:io';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Viewstudent extends StatelessWidget {
  String name;
  String age;
  String cls;
  String address;

  dynamic imagePath;
  Viewstudent({
    super.key,
    required this.name,
    required this.age,
    required this.cls,
    required this.address,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar( backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text('Profile',style: TextStyle(color: Colors.amber),),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: FileImage(File(imagePath)),
          ),
          const SizedBox(height: 40),
          SizedBox(
            child: Card(
                color: Colors.amber,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: const SizedBox(
                            height: 10,
                          ),
                        ),
                        Title(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          child: Text(
                            'Name:  $name',
                            style: TextStyle(
                                fontSize: 20,
                                color: const Color.fromARGB(255, 0, 0, 0),fontStyle: FontStyle.italic),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Title(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          child: Text(
                            'Age:  $age ',
                            style: TextStyle(
                                fontSize: 20,
                                color: const Color.fromARGB(255, 0, 0, 0),
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Title(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          child: Text(
                            'Class: $cls ',
                            style: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 0, 0, 0),fontStyle: FontStyle.italic),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Title(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          child: Text(
                            'Address: $address ',
                            style: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 0, 0, 0),fontStyle: FontStyle.italic),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
