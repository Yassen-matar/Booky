import 'package:booky/Features/book_library/domain/entities/book_entity.dart';
import 'package:booky/Features/book_library/domain/repos/book_library_repo.dart';
import 'package:booky/Features/search_book/domain/repos/book_library_repo.dart';
import 'package:booky/core/server/failure.dart';
import 'package:dartz/dartz.dart';


class FetchSearchBooksUseCase {
  final BookSearchRepo bookSearchRepo;

  FetchSearchBooksUseCase(this.bookSearchRepo);

  Future<Either<Failure, List<BookEntity>>> call({String? q}) async {
    return await bookSearchRepo.fetchSearchBooks(
      q: q,
    );
  }
}
