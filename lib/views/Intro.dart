import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:wallet/State/Controller.dart';

class Intro extends StatefulWidget {
  const Intro({Key key}) : super(key: key);

  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  Controller controller = Get.put(Controller());
  final introKey = GlobalKey<IntroductionScreenState>();
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Saiba quando irá receber seus proventos",
          body:
              "Fique informado sobre a data de pagamentos de outras informações importantes sobre seus Fundos Imobiliários.",
          image: const Center(
            child: Icon(Icons.android),
          ),
        ),
        PageViewModel(
          title: "Cotação em tempo real",
          body: "Saiba a cotação dos seus Fundos Imobiliários em tempo real.",
          image: const Center(
            child: Icon(Icons.android),
          ),
        ),
      ],
      onDone: () {
        controller.skipIntro();
        Navigator.pushNamed(context, '/homePage');
      },
      onSkip: () {
        // You can also override onSkip callback
      },
      showSkipButton: true,
      skip: Text('Pular'),
      next: Text('Proximo'),
      done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: DotsDecorator(
          size: const Size.square(10.0),
          activeSize: const Size(20.0, 10.0),
          color: Colors.black26,
          spacing: const EdgeInsets.symmetric(horizontal: 3.0),
          activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0))),
    );
  }
}
