part of 'search_book_cubit.dart';


sealed class SearchBookState {}

final class SearchBookInitial extends SearchBookState {}

final class SearchBookNoConnection extends SearchBookState {}

final class SearchBookLoading extends SearchBookState {}

final class SearchBookSuccess extends SearchBookState { 
    List<BookEntity> books; 
    SearchBookSuccess({required this.books});
}

final class SearchBookFailure extends SearchBookState { 
  String errorMessage ; 
  SearchBookFailure({required this.errorMessage});
}
