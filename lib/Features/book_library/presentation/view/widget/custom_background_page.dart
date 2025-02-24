
import 'package:booky/core/constant/app_color.dart';
import 'package:booky/core/constant/app_svg.dart';
import 'package:booky/core/responsive/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomBackGroundPage extends StatelessWidget {
  const CustomBackGroundPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView( 
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          Container(
            height: SizeConfig.screenHeight! * 0.4,
            decoration: const BoxDecoration(
                color: AppColor.primaryColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(100),
                    bottomRight: Radius.circular(100))),
          ), 
          SvgPicture.asset(AppSvg.backgroundForms ,  )
        ],
      ),
    );
  }
}
