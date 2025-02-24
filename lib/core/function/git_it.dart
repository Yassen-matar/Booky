import 'package:booky/Features/book_library/data/data_sources/book_library_remote_data_source.dart';
import 'package:booky/Features/book_library/data/repo_imp/book_library_repo_imp.dart';
import 'package:booky/Features/book_library/domain/use_cases/fetch_books_use_case.dart';
import 'package:booky/Features/book_library/domain/use_cases/fetch_search_books_use_case.dart';
import 'package:booky/Features/book_library/presentation/manager/cubit/book_library_cubit.dart';
import 'package:booky/Features/search_book/data/data_sources/book_search_remote_data_source.dart';
import 'package:booky/Features/search_book/data/repo_imp/book_search_repo_imp.dart';
import 'package:booky/Features/search_book/presentation/manager/cubit/search_book_cubit.dart';
import 'package:get_it/get_it.dart';

final getItInstance = GetIt.I;

Future<void> initCubit() async {
  getItInstance.registerLazySingleton<BookLibraryRepoImp>(
      () => BookLibraryRepoImp(BookLibraryRemoteDataSourceImpl()));

  getItInstance.registerLazySingleton<BookSearchRepoImp>(
      () => BookSearchRepoImp(BookSearchRemoteDataSourceImpl()));
/* ------------------------------------------------------------------- */
  getItInstance.registerLazySingleton<FetchBooksUseCase>(
      () => FetchBooksUseCase(getItInstance<BookLibraryRepoImp>()));

  getItInstance.registerLazySingleton<FetchSearchBooksUseCase>(
      () => FetchSearchBooksUseCase(getItInstance<BookSearchRepoImp>()));
  /* ----------------------------------------------------- */
  getItInstance.registerFactory<BookLibraryCubit>(() => BookLibraryCubit(
        getItInstance<FetchBooksUseCase>(),
      ));
      getItInstance.registerFactory<SearchBookCubit>(() => SearchBookCubit(
        getItInstance<FetchSearchBooksUseCase>(),
      ));
}
