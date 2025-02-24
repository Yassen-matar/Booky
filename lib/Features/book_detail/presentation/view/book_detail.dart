import 'package:booky/Features/book_library/domain/entities/book_entity.dart';
import 'package:booky/Features/book_library/presentation/view/widget/custom_app_bar.dart';
import 'package:booky/Features/book_library/presentation/view/widget/custom_book_image.dart';
import 'package:booky/core/constant/app_color.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constant/app_svg.dart';

class BookDetail extends StatelessWidget {
  BookDetail({super.key, required this.books});
  BookEntity books;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, () {
        context.push('/search');
      }),
      body: Stack(
        children: [
          SvgPicture.asset(
            AppSvg.backgroundForms,
          ),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column( 
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomBookImage(image: books.image ?? ""),
                    Text(books.title),
                    Text(books.authorName!),
                    /*   Text(books.rating.toString()), */
                    RatingBar.readOnly( 
                      alignment: Alignment.center,
                      filledColor: AppColor.primaryColor,
                      filledIcon: Icons.star,
                      emptyIcon: Icons.star_border,
                      initialRating: books.rating?.toDouble() ?? 0.0,
                      maxRating: 5,
                    ),
                    Text(books.description ?? "")
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
