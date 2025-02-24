import 'package:booky/Features/book_library/presentation/manager/cubit/book_library_cubit.dart';
import 'package:booky/Features/book_library/presentation/view/widget/book_library_body_view.dart';
import 'package:booky/Features/book_library/presentation/view/widget/custom_book_image.dart';
import 'package:booky/Features/book_library/presentation/view/widget/loading_scroll.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';

class StaggeredGridView extends StatelessWidget {
  StaggeredGridView(
      {super.key,
      required ScrollController scrollController,
      required this.widget,
      required this.state})
      : _scrollController = scrollController;
  BookLibraryState state;
  final ScrollController _scrollController;
  final BookLibraryBodyView widget;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(0),
        controller: _scrollController,
        child: MasonryGridView.count(
          physics:
              const NeverScrollableScrollPhysics(), // Disable GridView scrolling
          shrinkWrap: true, // Allow GridView to take only the needed height
          padding: const EdgeInsets.all(16.0),
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          itemCount: widget.books.length,
          itemBuilder: (context, index) {
            if (state is BookLibraryPaginationLoading &&
                index == widget.books.length - 1) {
              return const LoadingScroll();
            }

            return InkWell(
              onTap: () {
                context.push('/bookDetail', extra: widget.books[index]);
              },
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomBookImage(
                      image: widget.books[index].image ?? "",
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: 120,
                      child: Text(
                        widget.books[index].title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 120,
                      child: Text(
                        widget.books[index].authorName!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      )
          .animate()
          .moveY(begin: 200, duration: const Duration(milliseconds: 800)),
    );
  }
}
