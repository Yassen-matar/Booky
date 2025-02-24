
import 'package:booky/Features/book_library/domain/entities/book_entity.dart';
import 'package:booky/core/server/failure.dart';
import 'package:dartz/dartz.dart';

abstract class BookLibraryRepo {
  Future<Either<Failure, List<BookEntity>>> fetchBooks(
      {int pageNumber = 0});
        Future<Either<Failure, List<BookEntity>>> fetchSearchBooks({String? q}) ;
/*   Future<Either<Failure, List<BookEntity>>> fetchNewestBooks(); */
}


