
import 'package:booky/Features/book_library/domain/entities/book_entity.dart';
import 'package:booky/core/server/failure.dart';
import 'package:dartz/dartz.dart';

abstract class BookSearchRepo {

        Future<Either<Failure, List<BookEntity>>> fetchSearchBooks({String? q}) ;
}


