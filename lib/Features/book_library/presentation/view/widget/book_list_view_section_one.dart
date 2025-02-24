import 'package:booky/Features/book_library/domain/entities/book_entity.dart';
import 'package:booky/Features/book_library/presentation/view/widget/custom_book_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

class BookListViewSectionOne extends StatelessWidget {
  final List<BookEntity> books;

  const BookListViewSectionOne({super.key, required this.books});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              context.push('/bookDetail', extra: books[index]);
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: SizedBox(
                width: 150,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomBookImage(
                      image: books[index].image ?? "",
                    ),
                    const SizedBox(height: 5),
                    Text(
                      books[index].title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    Text(
                      books[index].authorName!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              )
                  .animate()
                  .fade(duration: const Duration(seconds: 1))
                  .scale(
                      delay: Duration(milliseconds: 200 * index),
                      duration: const Duration(seconds: 1))
                  .moveX(
                    begin: -50,
                    end: 0,
                    duration: const Duration(seconds: 1),
                    curve: Curves.easeOutBack,
                  )
                  .then()
                  .rotate(
                    begin: -0.2,
                    end: 0.1,
                    duration: const Duration(seconds: 1),
                    curve: Curves.easeInOut,
                  ),
            ),
          );
        },
      ),
    );
  }
}
