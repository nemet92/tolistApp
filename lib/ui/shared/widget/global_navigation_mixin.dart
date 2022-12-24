import 'package:flutter/widgets.dart';
import 'package:kartal/kartal.dart';
import 'package:tolesson/const/general_path.dart';

mixin GlobalNavigationMixin {
  void goToHomePage(BuildContext context) {
    context.navigateToReset(RoutePages.homePage.name);
  }
}
