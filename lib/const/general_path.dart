import 'package:flutter/material.dart';

mixin AppText {
  String password = "password";
  String nameHintText = "Name";
  String ageHintText = "Age";
  String mailHintText = "Mail";
  String buttonTextNext = "Next";
  String alertDialogText = "Task add";
  String alertTextFiled = "New task add";
  String errorText = "Bu xana bos qala bilmez!";
  String taskNumber = "Sizin qeydlerinizin sayi";
  String pageOneText =
      "To Do appilcation welcome! Lores ipsum Lores ipsum Lores ipsum Lores ipsum Lores ipsum Lores ipsum Lores ipsum Lores ipsum Lores ipsum ";

  String pageTwoText =
      "Lores ipsum Lores ipsum ,Lores ipsum Lores ipsum Lores ipsum Lores ipsum Lores ipsum Lores ipsum Lores ipsum Lores ipsum Lores ipsum Lores ipsum Lores ipsum Lores ipsum ,Lores ipsum Lores ipsum Lores ipsum Lores ipsum Lores ipsum Lores ipsum Lores ipsum Lores ipsum Lores ipsum Lores ipsum Lores ipsum Lores ipsum Lores ipsum ";
}

// Appilcation Colors
mixin AppColor {
  Color containerColor = const Color(0xffff973f);
  Color sunnyColor = Colors.lightBlue;
  Color darkColor = Colors.black;
}

// Apilcation Icons
mixin AppIcon {
  IconData iconNext = Icons.skip_next_rounded;
  Icon deleteIcon = const Icon(Icons.edit);
  Icon arrowForward = const Icon(Icons.arrow_forward);
  Icon sunny = const Icon(Icons.sunny);
  Icon dark = const Icon(Icons.dark_mode);
}

mixin AppImage {
  Image image1 = Image.asset("assets/image1.jpeg");
  Image image2 = Image.asset("assets/image2.jpeg");
}

mixin AppSize {
  final columnPadding = const EdgeInsets.symmetric(horizontal: 8, vertical: 16);
  final imagePadding = const EdgeInsets.only(top: 60);
  final sizedBox = const SizedBox(height: 20);
}
