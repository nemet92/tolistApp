import 'package:flutter/material.dart';
import 'package:tolesson/appPath.dart';
import 'package:tolesson/homePage.dart';
import 'package:tolesson/network.dart';
import 'package:tolesson/PostUserModel.dart';
import 'package:tolesson/widget/customElevatedButton.dart';

import 'widget/customTextFiled.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> with AppPath {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mailTextEditingController =
      TextEditingController();
  final TextEditingController _ageTextEditingController =
      TextEditingController();
  String name = " ";

  ProjectService projectService = GeneralService();

  Future<void> sendItemsToWebservice(Users toDoPostModel) async {
    projectService.infoPage(toDoPostModel);
    return;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: SingleChildScrollView(
            child: Column(
              children: [
                sizedBox(),
                Container(
                  padding: const EdgeInsets.all(16),
                  color: containerColor,
                  height: 400,
                  child: Column(
                    children: [
                      Center(
                        child: CustomTextFiled(
                          hintText: nameHintText,
                          controller: _nameController,
                        ),
                      ),
                      sizedBox(),
                      CustomTextFiled(
                        hintText: mailHintText,
                        controller: _mailTextEditingController,
                      ),
                      sizedBox(),
                      CustomTextFiled(
                        hintText: ageHintText,
                        controller: _ageTextEditingController,
                      ),
                    ],
                  ),
                ),
                sizedBox(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomElevatedButton(
                      onPressed: () {
                        setState(() {
                          final toDoPostModel = Users(
                              name: _nameController.text,
                              age: int.tryParse(
                                _ageTextEditingController.text,
                              ),
                              mail: _mailTextEditingController.text);
                          sendItemsToWebservice(toDoPostModel);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => Homepage(
                                        text: _nameController.text,
                                      ))));
                        });
                      },
                      icon: iconNext,
                      text: buttonTextNext,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox sizedBox() {
    return const SizedBox(
      height: 20,
    );
  }
}
