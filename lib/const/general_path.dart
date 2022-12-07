import 'package:flutter/material.dart';

mixin AppText {
  String nameHintText = "Name";
  String ageHintText = "Age";
  String mailHintText = "Mail";
  String buttonTextNext = "Next";
  String alertDialogText = "Task add";
  String alertTextFiled = "New task add";
  String errorText = "Bu xana bos qala bilmez!";
  String pageOneText =
      "To Do appilcation welcome! Lores ipsum Lores ipsum Lores ipsum Lores ipsum Lores ipsum Lores ipsum Lores ipsum Lores ipsum Lores ipsum ";

  String pageTwoText =
      "Lores ipsum Lores ipsum ,Lores ipsum Lores ipsum Lores ipsum Lores ipsum Lores ipsum Lores ipsum Lores ipsum Lores ipsum Lores ipsum Lores ipsum Lores ipsum Lores ipsum ,Lores ipsum Lores ipsum Lores ipsum Lores ipsum Lores ipsum Lores ipsum Lores ipsum Lores ipsum Lores ipsum Lores ipsum Lores ipsum Lores ipsum Lores ipsum ";
}

// Appilcation Colors
mixin AppColor {
  Color containerColor = const Color(0xffff973f);
}

// Apilcation Icons
mixin AppIcon {
  IconData iconNext = Icons.skip_next_rounded;
  Icon checkBox = const Icon(
    Icons.check_box,
    color: Colors.red,
  );
  // Icon IconDelete = IconButton(icon: const Icon(Icons.delete), onPressed: () {});
}

mixin AppImage {
  Image image1 = Image.asset("assets/image1.jpeg");
  Image image2 = Image.asset("assets/image2.jpeg");
}
