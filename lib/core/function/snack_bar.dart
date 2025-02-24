import 'package:booky/core/constant/app_color.dart';
import 'package:booky/core/constant/app_svg.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

void showTopSnackBar(String content, String label, BuildContext context) {
  final overlay = Overlay.of(context);
  final snackBarOverlay = OverlayEntry(
    builder: (context) => Positioned(
      top: 50.0, // You can adjust the top position
      left: 0,
      right: 0,
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: label == "error"
              ? CustomSnackBar(
                  message: content,
                  color: Colors.red,
                  icon: AppSvg.errorSnackL,
                )
              : label == "success"
                  ? CustomSnackBar(
                      message: content,
                      color: Colors.green,
                      icon: AppSvg.lightTrue,
                    )
                  : CustomSnackBar(
                      message: content,
                      color: Colors.yellowAccent,
                      icon: AppSvg.lightWarning,
                    ),
        ),
      ),
    ),
  );

  overlay.insert(snackBarOverlay);

  // Remove the snackbar after a few seconds
  Future.delayed(Duration(seconds: 3), () {
    snackBarOverlay.remove();
  });
}

snackBarWidgetBottom(
  String content,
  String label,
  context,
) {
  ScaffoldMessenger.of(context).showSnackBar(label == "success"
      ? SnackBar(
          margin: const EdgeInsets.only(bottom: 20),
          content: CustomSnackBar(
            message: content,
            color: Colors.green,
            icon: AppSvg.lightTrue,
          ),
          backgroundColor:
              Colors.transparent, // Make the SnackBar background transparent
          elevation: 0, // Remove the default shadow
          behavior: SnackBarBehavior
              .floating, // Make the SnackBar float above other content
          padding: const EdgeInsets.all(16.0), // Add padding to the SnackBar
        )
      : label == "error"
          ? SnackBar(
              content: CustomSnackBar(
                  message: content,
                  color: Colors.red,
                  icon: AppSvg.errorSnackL),
              backgroundColor: Colors
                  .transparent, // Make the SnackBar background transparent
              elevation: 0, // Remove the default shadow
              behavior: SnackBarBehavior
                  .floating, // Make the SnackBar float above other content
              padding:
                  const EdgeInsets.all(16.0), // Add padding to the SnackBar
            )
          : SnackBar(
              content: CustomSnackBar(
                  message: content,
                  color: Colors.yellowAccent,
                  icon: AppSvg.lightWarning),
              backgroundColor: Colors
                  .transparent, // Make the SnackBar background transparent
              elevation: 0, // Remove the default shadow
              behavior: SnackBarBehavior
                  .floating, // Make the SnackBar float above other content
              padding:
                  const EdgeInsets.all(16.0), // Add padding to the SnackBar
            ));
}

class CustomSnackBar extends StatefulWidget {
  final String message;
  String icon;
  Color color;
  CustomSnackBar(
      {required this.message, required this.icon, required this.color});

  @override
  _CustomSnackBarState createState() => _CustomSnackBarState();
}

class _CustomSnackBarState extends State<CustomSnackBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1.0, end: 0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));
    _controller.forward();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(blurRadius: 5, spreadRadius: 0.5, color: Colors.white)
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.only(
                  top: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10, top: 8, bottom: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 5,
                                        spreadRadius: 0,
                                        color: widget.color)
                                  ]),
                              child: SvgPicture.asset(widget.icon)),
                          const SizedBox(width: 12.0),
                          Expanded(
                            child: Text(
                              widget.message,
                              style: const TextStyle(
                                  fontSize: 13, color: AppColor.secandryColor),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        return Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              height: 2.0, // Underline thickness
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: widget.color,
                                  borderRadius: BorderRadius.circular(6),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 1.5,
                                        spreadRadius: 0,
                                        color: widget.color)
                                  ]),
                              height: 2.0, // Underline thickness
                              width: _animation.value *
                                  MediaQuery.of(context)
                                      .size
                                      .width, // Animate width from left
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
