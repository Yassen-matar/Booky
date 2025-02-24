import 'package:bloc/bloc.dart';
import 'package:booky/Features/book_library/domain/entities/book_entity.dart';
import 'package:booky/Features/book_library/domain/use_cases/fetch_books_use_case.dart';
import 'package:booky/core/function/check_internet.dart';
import 'package:meta/meta.dart';

part 'book_library_state.dart';

class BookLibraryCubit extends Cubit<BookLibraryState> {
  FetchBooksUseCase fetchBooksUseCase;
  BookLibraryCubit(this.fetchBooksUseCase) : super(BookLibraryInitial());
  
  List<BookEntity> books = [];
  /* page number to pagination */
  int pageNumber = 0;


  Future<void> fetchBooks({int pageNumber = 0}) async {
    if (pageNumber == 0) {
      emit(BookLibraryLoading());
    } else {
      emit(BookLibraryPaginationLoading());
    }
    if (await checkConnection()) {
      var result = await fetchBooksUseCase.call(pageNumber);
      result.fold((failure) {
        emit(BookLibraryFailure(failure.message));
      }, (books) {
        emit(BookLibrarySuccess(books));
      });
    } else {
      emit(BookLibraryNoConnection());
    }
  }

  void addBooksFromPagination(List<BookEntity> booksPg) {
    for (var element in booksPg) {
      books.add(element);
    }
  }
}
