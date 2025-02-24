import 'dart:developer';

import 'package:booky/Features/book_library/domain/entities/book_entity.dart';
import 'package:booky/core/server/config.dart';
import 'package:dio/dio.dart';

import '../../../book_library/data/models/book_model/book_model.dart';

abstract class BookSearchRemoteDataSource {
  Future<List<BookEntity>> fetchSearchBooks({String q});
/*   Future<List<BookEntity>> fetchFeaturedBooks({int pageNumber = 0});
  Future<List<BookEntity>> fetchNewestBooks(); */
}

class BookSearchRemoteDataSourceImpl extends BookSearchRemoteDataSource {
  ConfigApi configApi = ConfigApi(Dio());

  @override
  Future<List<BookEntity>> fetchSearchBooks({String? q}) async {
    var data = await configApi.get(completeUrl: 'volumes?q=$q');

    List<BookEntity> searchBooks = getBooksList(data);

    return searchBooks;
  }

  List<BookEntity> getBooksList(Map<String, dynamic> data) {
    List<BookEntity> books = [];
    for (var bookMap in data['items']) {
      books.add(BookModel.fromJson(bookMap));
    }
    return books;
  }
}
