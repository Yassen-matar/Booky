import 'package:bloc/bloc.dart';
import 'package:booky/Features/book_library/domain/entities/book_entity.dart';
import 'package:booky/Features/book_library/domain/use_cases/fetch_search_books_use_case.dart';
import 'package:booky/core/function/check_internet.dart';

part 'search_book_state.dart';

class SearchBookCubit extends Cubit<SearchBookState> {
  FetchSearchBooksUseCase fetchSearchBooksUseCase;
  SearchBookCubit(this.fetchSearchBooksUseCase) : super(SearchBookInitial());
  List<BookEntity> books = [];

  Future<void> fetchSearchBooks(String q) async {
    emit(SearchBookLoading());

    if (await checkConnection()) {
      var result = await fetchSearchBooksUseCase.call(q: q);
      result.fold((failure) {
        emit(SearchBookFailure(errorMessage: failure.message));
      }, (books) {
        emit(SearchBookSuccess(books: books));
      });
    } else {
      emit(SearchBookNoConnection());
    }
  }
}
