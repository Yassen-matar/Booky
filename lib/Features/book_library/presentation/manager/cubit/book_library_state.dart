part of 'book_library_cubit.dart';

@immutable
sealed class BookLibraryState {}

final class BookLibraryInitial extends BookLibraryState {}

final class BookLibraryLoading extends BookLibraryState {}
final class BookLibrarySuccessLocal extends BookLibraryState {}

final class BookLibraryPaginationLoading extends BookLibraryState {}
final class BookLibraryNoConnection extends BookLibraryState {}

final class BookLibrarySuccess extends BookLibraryState {
  final List<BookEntity> books;
  BookLibrarySuccess(this.books);
}

final class BookLibraryFailure extends BookLibraryState {
  final String errMessage;
  BookLibraryFailure(this.errMessage);
}
