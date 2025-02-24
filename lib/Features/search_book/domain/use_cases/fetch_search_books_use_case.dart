import 'package:booky/Features/book_library/domain/entities/book_entity.dart';
import 'package:booky/Features/book_library/domain/repos/book_library_repo.dart';
import 'package:booky/core/server/failure.dart';
import 'package:dartz/dartz.dart';


class FetchSearchBooksUseCase {
  final BookLibraryRepo bookLibraryRepo;

  FetchSearchBooksUseCase(this.bookLibraryRepo);

  Future<Either<Failure, List<BookEntity>>> call({String? q}) async {
    return await bookLibraryRepo.fetchSearchBooks(
      q: q,
    );
  }
}
