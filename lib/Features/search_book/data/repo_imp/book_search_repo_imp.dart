import 'package:booky/Features/book_library/domain/entities/book_entity.dart';
import 'package:booky/Features/search_book/data/data_sources/book_search_remote_data_source.dart';
import 'package:booky/Features/search_book/domain/repos/book_library_repo.dart';
import 'package:booky/core/server/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class BookSearchRepoImp extends BookSearchRepo {
  BookSearchRemoteDataSource bookSearchRemoteDataSource;
  BookSearchRepoImp(this.bookSearchRemoteDataSource);

  @override
  Future<Either<Failure, List<BookEntity>>> fetchSearchBooks(
      {String? q}) async {
    List<BookEntity> searchBooks;
    try {
      searchBooks =
          await bookSearchRemoteDataSource.fetchSearchBooks(q: q ?? "");
      return right(searchBooks);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
