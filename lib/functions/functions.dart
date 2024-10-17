import 'dart:developer';
import 'package:crud_app/model/student.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

ValueNotifier<List<Student>> studentListNotifier = ValueNotifier([]);
Future<void> addStudent(Student value) async {
  final studentDb = await Hive.openBox<Student>('student_db');
  await studentDb.add(value);
  studentListNotifier.value.add(value);
  log(value.name!);
  studentListNotifier.notifyListeners();
}

Future<void> getAllStudents() async {
  final studentDb = await Hive.openBox<Student>('student_db');
  studentListNotifier.value.clear();
  studentListNotifier.value.addAll(studentDb.values);
  // log(studentDb.values.toString());
  studentListNotifier.notifyListeners();
}

Future<void> deleteStudent(int index) async {
  final studentDb = await Hive.openBox<Student>('student_db');
  await studentDb.deleteAt(index);
  getAllStudents();
}

Future<void> editing(index, Student value) async {
  final studentDb = await Hive.openBox<Student>('student_db');
  studentListNotifier.value.clear();
  studentListNotifier.value.addAll(studentDb.values);
  studentListNotifier.notifyListeners();
  studentDb.putAt(index, value);
  getAllStudents();
}
