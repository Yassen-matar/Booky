import 'package:booky/Features/search_book/domain/repos/book_library_repo.dart';
import 'package:booky/core/server/failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/book_entity.dart';

class FetchSearchBooksUseCase {
  final BookSearchRepo bookSearchRepo;

  FetchSearchBooksUseCase(this.bookSearchRepo);

  Future<Either<Failure, List<BookEntity>>> call({String? q}) async {
    return await bookSearchRepo.fetchSearchBooks(
      q: q,
    );
  }
}
