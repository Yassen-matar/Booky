import 'package:booky/Features/book_library/presentation/view/widget/custom_app_bar.dart';
import 'package:booky/Features/book_library/presentation/view/widget/custom_background_page.dart';
import 'package:booky/Features/book_library/presentation/view/widget/shimmer_book.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class LoadingBookLibraryPage extends StatelessWidget {
  const LoadingBookLibraryPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(context ,(){}),
        body: Stack(
          children: [
            const CustomBackGroundPage(),
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 230,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (BuildContext context, int index) {
                        return const ShimmerBook();
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 150,
                  ),
                  MasonryGridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return const ShimmerBook();
                    },
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
