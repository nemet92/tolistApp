import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:tolesson/const/general_path.dart';
import 'package:tolesson/ui/screens/user_info_page.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> with AppText {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: IntroductionScreen(
          skipOrBackFlex: 0,
          nextFlex: 0,
          next: const Icon(Icons.arrow_forward),
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
                  child: Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: Image.asset(
                      "assets/image1.jpeg",
                      // scale: 1,
                    ),
                  ),
                )
                // image: buildImage("assets/image1.jpeg")
                ),
            PageViewModel(
                title: "Lores Ipsum",
                body: pageTwoText,
                image: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: Image.asset(
                      "assets/image2.jpeg",
                    ),
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
          done: const Icon(Icons.arrow_forward),
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
