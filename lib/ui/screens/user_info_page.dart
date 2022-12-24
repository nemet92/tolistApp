import 'package:flutter/material.dart';
import 'package:tolesson/const/general_path.dart';
import 'package:tolesson/ui/screens/homePage/home_page.dart';
import 'package:tolesson/ui/service/service.dart';
import 'package:tolesson/ui/model/post_user_model.dart';
import 'package:tolesson/ui/shared/widget/custom_elevated_button.dart';

import '../../yLib/shared/custom_filed.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo>
    with AppText, AppColor, AppIcon, AppSize {
  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _mailTextEditingController =
      TextEditingController();
  final TextEditingController _ageTextEditingController =
      TextEditingController();
  bool _validateName = false;
  bool _validateMail = false;
  bool _validateAge = false;
  @override
  void dispose() {
    _nameEditingController.dispose();
    _mailTextEditingController.dispose();
    _ageTextEditingController.dispose();
    super.dispose();
  }

  String name = " ";

  ProjectService projectService = GeneralService();

  Future<void> sendItemsToWebservice(Users toDoPostModel) async {
    projectService.signIn(toDoPostModel);
    return;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Accaunt information"),
        ),
        body: Padding(
          padding: columnPadding,
          child: SingleChildScrollView(
            child: Column(
              children: [
                sizedBox,
                Container(
                  padding: const EdgeInsets.all(16),
                  color: containerColor,
                  height: 400,
                  child: Column(
                    children: [
                      Center(
                        child: CustomTextFiled(
                          errorText: errorText,
                          hintText: nameHintText,
                          controller: _nameEditingController,
                          validate: _validateName,
                        ),
                      ),
                      sizedBox,
                      CustomTextFiled(
                        errorText: errorText,
                        validate: _validateMail,
                        hintText: mailHintText,
                        controller: _mailTextEditingController,
                      ),
                      sizedBox,
                      CustomTextFiled(
                        keypoardType: TextInputType.number,
                        errorText: errorText,
                        validate: _validateAge,
                        hintText: ageHintText,
                        controller: _ageTextEditingController,
                      ),
                    ],
                  ),
                ),
                sizedBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomElevatedButton(
                      onPressed: () {
                        setState(() {
                          _nameEditingController.text.isEmpty
                              ? _validateName = true
                              : _validateName = false;
                          _mailTextEditingController.text.isEmpty
                              ? _validateMail = true
                              : _validateMail = false;
                          _ageTextEditingController.text.isEmpty
                              ? _validateAge = true
                              : _validateAge = false;

                          if (_validateName == false &&
                              _validateMail == false &&
                              _validateAge == false) {
                            final toDoPostModel = Users(
                                name: _nameEditingController.text,
                                age: int.tryParse(
                                  _ageTextEditingController.text,
                                ),
                                email: _mailTextEditingController.text);
                            sendItemsToWebservice(toDoPostModel);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => Homepage(
                                          text: _nameEditingController.text,
                                        ))));
                          }
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
}
