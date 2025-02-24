import 'package:booky/Features/book_library/domain/entities/book_entity.dart';
import 'package:booky/Features/book_library/presentation/manager/cubit/book_library_cubit.dart';
import 'package:booky/Features/book_library/presentation/view/widget/book_library_body_view.dart';
import 'package:booky/Features/book_library/presentation/view/widget/custom_book_image.dart';
import 'package:booky/Features/book_library/presentation/view/widget/loading_scroll.dart';
import 'package:booky/Features/search_book/presentation/manager/cubit/search_book_cubit.dart';
import 'package:booky/Features/search_book/presentation/view/search_book.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';

class StaggerdGridViewSearch extends StatelessWidget {
  StaggerdGridViewSearch({super.key, required this.books, required this.state});

  SearchBookState state;

  List<BookEntity> books = [];

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      physics: const BouncingScrollPhysics(), // Disable GridView scrolling
      shrinkWrap: true, // Allow GridView to take only the needed height
      padding: const EdgeInsets.all(16.0),
      crossAxisCount: 2,
      mainAxisSpacing: 20,
      crossAxisSpacing: 20,
      itemCount: books.length,
      itemBuilder: (context, index) {
        return InkWell(
              onTap: () {
                context.push('/bookDetail', extra: books[index]);
              },
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomBookImage(
                  image: books[index].image ?? "",
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: 120,
                  child: Text(
                    books[index].title,
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
                    books[index].authorName!,
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
    ).animate().moveY(begin: 200, duration: const Duration(milliseconds: 800));
  }
}
