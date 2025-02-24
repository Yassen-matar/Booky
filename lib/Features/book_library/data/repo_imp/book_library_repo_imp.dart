import 'package:booky/Features/book_library/data/data_sources/book_library_remote_data_source.dart';
import 'package:booky/Features/book_library/domain/entities/book_entity.dart';
import 'package:booky/Features/book_library/domain/repos/book_library_repo.dart';
import 'package:booky/core/server/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class BookLibraryRepoImp extends BookLibraryRepo {
  BookLibraryRemoteDataSource bookLibraryRemoteDataSource;
  BookLibraryRepoImp(this.bookLibraryRemoteDataSource);

  @override
  Future<Either<Failure, List<BookEntity>>> fetchBooks(
      {int pageNumber = 0}) async {
    List<BookEntity> booksList;
    try {
      booksList =
          await bookLibraryRemoteDataSource.fetchBooks(pageNumber: pageNumber);
      return right(booksList);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

}
