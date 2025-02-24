
import 'package:booky/Features/book_library/domain/repos/book_library_repo.dart';
import 'package:booky/core/server/failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/book_entity.dart';

class FetchBooksUseCase {
  final BookLibraryRepo bookLibraryRepo ; 

  FetchBooksUseCase(this.bookLibraryRepo);

  Future<Either<Failure, List<BookEntity>>> call([int param = 0]) async {
    return await bookLibraryRepo.fetchBooks(
      pageNumber: param,
    );
  }
}
