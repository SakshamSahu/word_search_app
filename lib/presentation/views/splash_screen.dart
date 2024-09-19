import 'package:flutter/material.dart';
import 'package:word_search_app/presentation/views/home_screen.dart';
import 'package:word_search_app/utils/assets.dart';
import 'package:word_search_app/utils/constants/colors.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 3000), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.splashscreenbgcolor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Assets.logo,
              width: width * 0.4,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            Image.asset(
              Assets.logoText,
              width: width * 0.6,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
