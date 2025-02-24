import 'package:booky/Features/book_library/presentation/view/widget/custom_app_bar.dart';
import 'package:booky/Features/book_library/presentation/view/widget/shimmer_book.dart';
import 'package:booky/Features/search_book/presentation/manager/cubit/search_book_cubit.dart';
import 'package:booky/Features/search_book/presentation/view/widget/loading_search_page.dart';
import 'package:booky/Features/search_book/presentation/view/widget/staggerd_grid_view_search.dart';
import 'package:booky/core/function/git_it.dart';
import 'package:booky/core/function/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SearchBook extends StatelessWidget {
  const SearchBook({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => getItInstance<SearchBookCubit>(),
        child: BlocConsumer<SearchBookCubit, SearchBookState>(
          listener: (context, state) {
            if (state is SearchBookSuccess) {
              BlocProvider.of<SearchBookCubit>(context).books = state.books;
            }
            if (state is SearchBookFailure) {
              snackBarWidgetBottom(state.errorMessage, "error", context);
            }
            if (state is SearchBookNoConnection) {
              snackBarWidgetBottom("Check Connection", "warning", context);
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: customSearchAppBar(
                context,
              ),
              body: (state is SearchBookLoading)
                  ? const LoadingSearchPage()
                  : StaggerdGridViewSearch(
                      state: state,
                      books: BlocProvider.of<SearchBookCubit>(context).books,
                    ),
            );
          },
        ));
  }
}
