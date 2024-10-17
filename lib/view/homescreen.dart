import 'dart:io';
import 'package:crud_app/functions/functions.dart';
import 'package:crud_app/model/student.dart';
import 'package:crud_app/view/addstudent.dart';
import 'package:crud_app/view/editstudent.dart';
import 'package:crud_app/view/loginPage.dart';
import 'package:crud_app/view/viewstudent.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String search = '';
  List<Student> searchedList = [];
  void searchListUpdate() {
    getAllStudents();
    searchedList = studentListNotifier.value
        .where((stdModel) =>
            stdModel.name!.toLowerCase().contains(search.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    searchListUpdate();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        child: const Icon(Icons.person_add_alt),
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const Addstudent()));
        },
      ),
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        leading: Icon(
          Icons.book,
          color: Colors.amber,
        ),
        title: const Text(
          'Student List',
          style: TextStyle(color: Colors.amber),
        ),
        actions: [
          IconButton(
              icon: const Icon(
                Icons.logout,
                color: Colors.amber,
              ),
              onPressed: () async{ 
                SharedPreferences preferences = await SharedPreferences.getInstance();
await preferences.clear();
                Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                  return Loginpage();
                }));
              }),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              style: const TextStyle(color: Colors.white),
              onChanged: (value) {
                setState(() {
                  search = value;
                  searchListUpdate();
                });
              },
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  labelText: 'Search',
                  labelStyle: TextStyle(
                      color: Colors.white, fontStyle: FontStyle.italic),
                  focusColor: Colors.white,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.amber,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30))),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: studentListNotifier,
              builder:
                  (BuildContext, List<Student> studentList, Widget? child) {
                return search.isNotEmpty
                    ? searchedList.isEmpty
                        ? const Center(
                            child: Text(
                              'No results found.',
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        : _buildStudentList(searchedList)
                    : _buildStudentList(studentList);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStudentList(List<Student> students) {
    return students.isEmpty
        ? const Center(
            child: Text(
              'No students available.',
              style: TextStyle(color: Colors.white),
            ),
          )
        : ListView.separated(
            itemCount: students.length,
            itemBuilder: (context, index) {
              final data = students[index];
              return ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Viewstudent(
                        name: data.name!,
                        age: data.age!,
                        cls: data.cls!,
                        address: data.address!,
                        imagePath: data.imagePath,
                      ),
                    ),
                  );
                },
                title: Text(
                  data.name!,
                  style: const TextStyle(color: Colors.white),
                ),
                leading: CircleAvatar(
                  backgroundColor: const Color.fromARGB(255, 25, 25, 81),
                  backgroundImage: data.imagePath != null
                      ? FileImage(File(data.imagePath ?? "N/A"))
                      : const AssetImage("assets/download.jpeg")
                          as ImageProvider,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => EditStudent(
                              index: index,
                              name: data.name!,
                              cls: data.cls!,
                              address: data.address!,
                              age: data.age!,
                              imagePath: data.imagePath,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.amber,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Confirm Deletion'),
                              content: const Text(
                                  'Are you sure you want to delete this student?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    deleteStudent(index);
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Delete'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.amber,
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Divider(
                  color: Colors.amber,
                ),
              );
            },
          );
  }
}
