import 'package:booky/Features/book_library/presentation/manager/cubit/book_library_cubit.dart';
import 'package:booky/Features/book_library/presentation/view/widget/book_library_body_view.dart';
import 'package:booky/Features/book_library/presentation/view/widget/custom_app_bar.dart';
import 'package:booky/Features/book_library/presentation/view/widget/loadin_book_library_page.dart';

import 'package:booky/core/function/git_it.dart';
import 'package:booky/core/function/snack_bar.dart';
import 'package:booky/core/responsive/size_config.dart';
import 'package:booky/core/storage/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BookLibrary extends StatelessWidget {
  const BookLibrary({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
      create: (_) => getItInstance<BookLibraryCubit>()..fetchLocalBooks(),
      child: BlocConsumer<BookLibraryCubit, BookLibraryState>(
        listener: (context, state) async {
          if (state is BookLibraryFailure) {
            snackBarWidgetBottom(state.errMessage, "error", context);
          }
          if (state is BookLibrarySuccess) {
            BlocProvider.of<BookLibraryCubit>(context)
                .addBooksFromPagination(state.books);
            await SecureStorage.setBooks(
                BlocProvider.of<BookLibraryCubit>(context).books);
          }
          if (state is BookLibraryNoConnection) {
            snackBarWidgetBottom("Check Connection", "warning", context);
          }
        },
        builder: (context, state) {
          if (state is BookLibraryLoading) {
            return const LoadingBookLibraryPage();
          }
          return Scaffold(
              appBar: customAppBar(context, () {
                context.push("/search");
              }),
              body: RefreshIndicator(
                onRefresh: () {
                  BookLibraryCubit cubit =
                      BlocProvider.of<BookLibraryCubit>(context);
                  cubit.books = [];
cubit.pageNumber = 0;
                  return cubit.fetchBooks(pageNumber: 0);
                },
                child: BookLibraryBodyView(
                  books: context.read<BookLibraryCubit>().books,
                ),
              ));
        },
      ),
    );
  }
}
