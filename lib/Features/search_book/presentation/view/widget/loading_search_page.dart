
import 'package:booky/Features/book_library/presentation/view/widget/shimmer_book.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class LoadingSearchPage extends StatelessWidget {
  const LoadingSearchPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        itemCount: 4,
        itemBuilder: (context, index) {
          return const ShimmerBook();
        },
      );
  }
}
