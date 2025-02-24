import 'package:booky/Features/book_library/data/data_sources/book_library_remote_data_source.dart';
import 'package:booky/Features/book_library/data/repo_imp/book_library_repo_imp.dart';
import 'package:booky/Features/book_library/domain/use_cases/fetch_books_use_case.dart';
import 'package:booky/Features/book_library/presentation/manager/cubit/book_library_cubit.dart';
import 'package:get_it/get_it.dart';

final getItInstance = GetIt.I;

Future<void> initCubit() async {
  getItInstance.registerLazySingleton<BookLibraryRepoImp>(
      () => BookLibraryRepoImp(BookLibraryRemoteDataSourceImpl()));

  getItInstance.registerLazySingleton<FetchBooksUseCase>(
      () => FetchBooksUseCase(getItInstance<BookLibraryRepoImp>()));
  getItInstance.registerFactory<BookLibraryCubit>(() => BookLibraryCubit(
        getItInstance<FetchBooksUseCase>(),
      ));
}
