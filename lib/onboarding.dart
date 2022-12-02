import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:tolesson/const/appText.dart';
import 'package:tolesson/threePage.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

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
                body: AppText.pageOneText,
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
                body: AppText.pageTwoText,
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
        // color: Colors.red,
        activeColor: Colors.amber,
      );

  void goToHome(context) => Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (_) => const ThreePage()));
}
