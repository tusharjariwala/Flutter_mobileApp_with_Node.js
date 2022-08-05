import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_navigator/components/profileDetailRaw.dart';
import 'package:flutter_navigator/components/studentListRaw.dart';
import 'package:flutter_navigator/pojo/studentData.dart';
import 'package:flutter_navigator/pojo/studentListResponse.dart';
import 'package:flutter_navigator/services/rest_api.dart';
import 'package:flutter_navigator/utils/config.dart';
import 'package:flutter_navigator/utils/constant.dart';

class StudentListScreen extends StatefulWidget {
  static const String id = "StudentListScreen";

  const StudentListScreen({Key? key}) : super(key: key);

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  Config config = Config();
  RestApi restApi = RestApi();
  bool showSpinner = false;
  List<StudentData> studentList = [];

  @override
  void initState() {
    getStudentList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Data List'),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: KDarkAppBarColor,
      ),
      body: SingleChildScrollView(
        child: showSpinner
            ? config.loadingView()
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: studentList.length,
                itemBuilder: (context, index) {
                  return StudentListRaw(studentData: studentList[index]);
                }),
          ],
        ),
      ),
    );
  }

  void getStudentList() async {
    try {
      if (mounted) {
        setState(() {
          showSpinner = true;
        });
      }
      //String id = await config.getStringSharedPreferences("userID");
      studentListResponse? response = await restApi.getStudentList();
      if (response != null) {
        if (response.result == "success") {
          config.showToastSuccess(response.msg);
          studentList = response.data!;
        } else {
          config.showToastFailure(response.msg);
        }
      } else {
        config.showToastFailure(SERVICE_FAILURE);
      }
      if (mounted) {
        setState(() {
          showSpinner = false;
        });
      }
    } catch (ex) {
      if (kDebugMode) {
        print(ex);
      }

      if (mounted) {
        setState(() {
          showSpinner = false;
        });
      }
    }
  }
}
