import 'dart:developer';

import 'package:booky/Features/book_library/domain/entities/book_entity.dart';
import 'package:booky/core/server/config.dart';
import 'package:dio/dio.dart';

import '../models/book_model/book_model.dart';

abstract class BookLibraryRemoteDataSource {
  Future<List<BookEntity>> fetchBooks({int pageNumber = 0});
  Future<List<BookEntity>> fetchSearchBooks({String q});
/*   Future<List<BookEntity>> fetchFeaturedBooks({int pageNumber = 0});
  Future<List<BookEntity>> fetchNewestBooks(); */
}

class BookLibraryRemoteDataSourceImpl extends BookLibraryRemoteDataSource {
  ConfigApi configApi = ConfigApi(Dio());
  @override
  Future<List<BookEntity>> fetchBooks({int pageNumber = 0}) async {
    try {
      var data = await configApi.get(
          completeUrl:
              'volumes?Filtering=free-ebooks&q=programming&startIndex=${pageNumber * 10}');

      List<BookEntity> books = getBooksList(data);

      return books;
    } catch (e) {
      throw Exception("There Error Please open vpn and try again");
    }
  }

  List<BookEntity> getBooksList(Map<String, dynamic> data) {
    List<BookEntity> books = [];
    for (var bookMap in data['items']) {
      books.add(BookModel.fromJson(bookMap));
    }
    return books;
  }

  @override
  Future<List<BookEntity>> fetchSearchBooks({String? q}) async {
    try {
      var data = await configApi.get(completeUrl: 'volumes?q=$q');

      List<BookEntity> searchBooks = getBooksList(data);

      return searchBooks;
    } catch (e) {
      throw Exception("There Error Please open vpn and try again");
    }
  }
}
