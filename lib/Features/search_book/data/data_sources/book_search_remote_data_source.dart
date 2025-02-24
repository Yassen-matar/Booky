
import 'package:booky/Features/book_library/domain/entities/book_entity.dart';
import 'package:booky/core/server/config.dart';
import 'package:dio/dio.dart';

import '../../../book_library/data/models/book_model/book_model.dart';

abstract class BookSearchRemoteDataSource {
  Future<List<BookEntity>> fetchSearchBooks({String q});

}

class BookSearchRemoteDataSourceImpl extends BookSearchRemoteDataSource {
  ConfigApi configApi = ConfigApi(Dio());

  @override
  Future<List<BookEntity>> fetchSearchBooks({String? q}) async {
    try {
      var data = await configApi.get(completeUrl: 'volumes?q=$q');

      List<BookEntity> searchBooks = getBooksList(data);

      return searchBooks;
    } on Exception {
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
}
