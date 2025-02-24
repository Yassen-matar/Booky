
import 'package:booky/core/constant/app_color.dart';
import 'package:flutter/material.dart';

class LoadingScroll extends StatelessWidget {
  const LoadingScroll({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
         child: Padding(
       padding: EdgeInsets.only(
           top: 8.0, left: 8, right: 8, bottom: 70),
       child: CircularProgressIndicator(
         color: AppColor.primaryColor,
       ),
     ));
  }
}