import 'package:flutter/material.dart';
import 'package:flutter_navigator/components/profileDetailRaw.dart';
import 'package:flutter_navigator/pojo/studentData.dart';

class StudentListRaw extends StatelessWidget {
  final StudentData studentData;

  const StudentListRaw({Key? key, required this.studentData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1.0, color: Colors.grey),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: [
            ProfileDetailRaw(title: "Roll No.: ", detail: studentData.rollNo!),
            ProfileDetailRaw(title: "Name: ", detail: studentData.studentName!),
            ProfileDetailRaw(title: "Gender: ", detail: studentData.gender!),
            ProfileDetailRaw(
                title: "contact No.: ", detail: studentData.contactNo!),
            ProfileDetailRaw(title: "E-mail: ", detail: studentData.email!),
            ProfileDetailRaw(
                title: "Languages: ", detail: studentData.language!),
          ],
        ),
      ),
    );
  }
}
