import 'package:booky/Features/book_library/presentation/view/widget/skelton.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerBook extends StatelessWidget {
  const ShimmerBook({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Shimmer.fromColors(
        baseColor:
            const Color.fromARGB(255, 82, 82, 82) /*         : Colors.white */,
        highlightColor:
            const Color.fromARGB(255, 131, 142, 204).withOpacity(0.90),
        child: Skeleton(
          width: MediaQuery.sizeOf(context).width * 40 / 100,
          height: 230,
        ),
      ),
    );
  }
}
