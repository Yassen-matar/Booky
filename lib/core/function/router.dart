import 'package:booky/Features/book_library/presentation/view/book_library.dart';
import 'package:booky/Features/search_book/presentation/view/search_book.dart';
import 'package:booky/Features/splash/presentation/view/splash.dart';
import 'package:go_router/go_router.dart';

// GoRouter configuration
final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const Splash(),
    ),
    GoRoute(
      path: '/bookLibrary',
      builder: (context, state) => const BookLibrary(),
    ),
    GoRoute(
      path: '/search',
      builder: (context, state) => const SearchBook(),
    ),
  ],
);
