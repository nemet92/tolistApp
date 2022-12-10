import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:tolesson/const/general_path.dart';
import 'package:tolesson/ui/screens/user_info_page.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage>
    with AppText, AppImage, AppSize, AppIcon {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: IntroductionScreen(
          skipOrBackFlex: 0,
          nextFlex: 0,
          next: arrowForward,
          showSkipButton: true, dotsDecorator: getPageDecoration(),
          skip: const Text(
            "Skip",
          ),
          onSkip: () => goToHome(context),
          pages: [
            PageViewModel(
                title: "Hi!",
                body: pageOneText,
                image: Center(
                  child: Padding(padding: imagePadding, child: image1),
                )),
            PageViewModel(
                title: "Lores Ipsum",
                body: pageTwoText,
                image: Center(
                  child: Padding(
                    padding: imagePadding,
                    child: image2,
                  ),
                )
                // footer: ElevatedButton(
                //   onPressed: () {
                //     Navigator.of(context).pushReplacement(
                //         MaterialPageRoute(builder: (_) => const HomePage()));
                //   },
                //   child: const Text("data"),
                // ),
                ),
          ],
          done: arrowForward,
          // onDone: () => goToHome(context),
          onDone: () {
            goToHome(context);
          },
        ),
      );

  DotsDecorator getPageDecoration() => const DotsDecorator(
        activeColor: Colors.amber,
      );

  void goToHome(context) => Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (_) => const UserInfo()));
}
