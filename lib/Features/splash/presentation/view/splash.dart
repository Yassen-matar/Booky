import 'package:booky/core/constant/app_color.dart';
import 'package:booky/core/constant/app_svg.dart';
import 'package:booky/core/responsive/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        Future.delayed(const Duration(milliseconds: 1500)).then((value) async {
          context.go('/bookLibrary');
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
                right: 50,
                top: 50,
                child: SvgPicture.asset(
                  AppSvg.shapSplash,
                )),
            Container(
              margin: EdgeInsets.only(top: SizeConfig.screenHeight! * 0.2),
              alignment: Alignment.topCenter,
              child: const Text(
                "Booky",
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: AppColor.primaryColor,
                    fontSize: 66),
              ),
            ).animate().moveX(
                begin: 300,
                curve: Curves.easeInOutBack,
                duration: const Duration(milliseconds: 750)),
            Positioned(bottom: 0, child: SvgPicture.asset(AppSvg.personRead))
                .animate()
                .moveY(
                    begin: 300,
                    curve: Curves.easeInOutBack,
                    duration: const Duration(milliseconds: 750)),
          ],
        ),
      ),
    );
  }
}
