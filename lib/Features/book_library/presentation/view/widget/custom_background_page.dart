
import 'package:booky/core/constant/app_color.dart';
import 'package:booky/core/responsive/size_config.dart';
import 'package:flutter/material.dart';

class CustomBackGroundPage extends StatelessWidget {
  const CustomBackGroundPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight! * 0.4,
      decoration: const BoxDecoration(
          color: AppColor.primaryColor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(100),
              bottomRight: Radius.circular(100))),
    );
  }
}
