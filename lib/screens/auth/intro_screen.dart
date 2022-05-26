import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttter_authentication/repository/auth_repositories.dart';
import 'package:fluttter_authentication/screens/auth/login_screen.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../../configs/theme.dart' as Styles;

class IntroScreen extends StatefulWidget {
  final AuthRepositories authRepositories;
  const IntroScreen({Key? key, required this.authRepositories})
      : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  late AuthRepositories _authRepositories;
  _IntroScreenState();

  bool _clicked = false;

  @override
  void initState() {
    _authRepositories = widget.authRepositories;
    _authRepositories.getStorageValue('skip_intro').then((value) {
      if (value == 'true') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(
              authRepositories: _authRepositories,
            ),
          ),
        );
      }
    });
    super.initState();
  }

  void afterIntroComplete() {
    _authRepositories.setStorageValue('skip_intro', 'true');
    setState(() {
      _clicked = true;
    });
  }

  final List<PageViewModel> pages = [
    PageViewModel(
      titleWidget: Column(
        children: [
          const Text('FREE GIFT'),
          const SizedBox(height: 10),
          Container(
            height: 3,
            width: 100,
            decoration: BoxDecoration(
              color: Styles.Colors.mainColor,
              borderRadius: BorderRadius.circular(10),
            ),
          )
        ],
      ),
      body:
          "Free gift with purchase. Offer free gift like a gift wrap, gift card or any free product",
      image: Center(
        child: SvgPicture.asset('assets/icons/gift.svg'),
      ),
      decoration: const PageDecoration(
        pageColor: Colors.white,
        bodyTextStyle: TextStyle(
          color: Colors.black54,
          fontSize: 16,
        ),
        bodyPadding: EdgeInsets.only(left: 20, right: 20),
        imagePadding: EdgeInsets.all(20),
      ),
    ),
    PageViewModel(
      titleWidget: Column(
        children: <Widget>[
          const Text(
            'PAYMENT INTEGRATION',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            height: 3,
            width: 100,
            decoration: BoxDecoration(
                color: Styles.Colors.mainColor,
                borderRadius: BorderRadius.circular(10)),
          )
        ],
      ),
      body:
          "A payment gateway as a merchant service that processes credit card payments for ecommerce sites and traditional brick and mortar stores.",
      image: Center(
          child: SizedBox(
        width: 450.0,
        child: SvgPicture.asset("assets/icons/payment.svg"),
      )),
      decoration: const PageDecoration(
          pageColor: Colors.white,
          bodyTextStyle: TextStyle(
            color: Colors.black54,
            fontSize: 16,
          ),
          bodyPadding: EdgeInsets.only(left: 20, right: 20),
          imagePadding: EdgeInsets.all(20)),
    ),
    PageViewModel(
      titleWidget: Column(
        children: <Widget>[
          const Text(
            'CALL CENTER',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            height: 3,
            width: 100,
            decoration: BoxDecoration(
                color: Styles.Colors.mainColor,
                borderRadius: BorderRadius.circular(10)),
          )
        ],
      ),
      body:
          "Call center gives a small business a big business feel. 24-hour sales, order entry, payment processing, billing inquiries, and more.",
      image: Center(
          child: SizedBox(
        width: 450.0,
        child: SvgPicture.asset("assets/icons/call.svg"),
      )),
      decoration: const PageDecoration(
          pageColor: Colors.white,
          bodyTextStyle: TextStyle(
            color: Colors.black54,
            fontSize: 16,
          ),
          bodyPadding: EdgeInsets.only(left: 20, right: 20),
          imagePadding: EdgeInsets.all(20)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return _clicked
        ? LoginScreen(
            authRepositories: _authRepositories,
          )
        : IntroductionScreen(
            pages: pages,
            onDone: afterIntroComplete,
            onSkip: afterIntroComplete,
            showSkipButton: true,
            skip: const Text(
              'Skip',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
            done: const Text(
              'Done',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            next: const Icon(Icons.navigate_next),
            dotsDecorator: DotsDecorator(
              size: const Size.square(7),
              activeSize: const Size(20, 5),
              activeColor: Styles.Colors.mainColor,
              color: Colors.black,
              spacing: const EdgeInsets.symmetric(horizontal: 3.0),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          );
  }
}
