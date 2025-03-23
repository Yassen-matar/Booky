import 'package:booky/Features/book_library/presentation/manager/cubit/book_library_cubit.dart';
import 'package:booky/Features/search_book/presentation/manager/cubit/search_book_cubit.dart';
import 'package:booky/core/constant/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

AppBar customAppBar(BuildContext context, onPressed) {
  return AppBar(
    leading: InkWell(
        onTap: () async {
          BookLibraryCubit cubit = BlocProvider.of<BookLibraryCubit>(context);
          cubit.books = [];
          cubit.pageNumber = 0;
          await cubit.fetchBooks(pageNumber: 0);
        },
        child: Icon(Icons.replay_outlined)),
    backgroundColor: AppColor.primaryColor,
    title: const Text(
      'Booky',
      style: TextStyle(color: Colors.white),
    ),
    centerTitle: true,
    actions: [
      IconButton(
        icon: const Icon(Icons.search, color: Colors.white),
        onPressed: onPressed,
      ),
    ],
  );
}

AppBar customSearchAppBar(
  BuildContext context,
) {
  return AppBar(
    backgroundColor: AppColor.primaryColor,
    title: TextField(
      controller: BlocProvider.of<SearchBookCubit>(context).searchController,
      onChanged: (val) async {
        val.length > 2
            ? await BlocProvider.of<SearchBookCubit>(context)
                .fetchSearchBooks(val)
            : null;
      },
      cursorColor: Colors.white.withOpacity(0.5),
      decoration: InputDecoration(
        hintText: 'Search...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
      ),
      style: const TextStyle(color: Colors.white, fontSize: 18),
    ),
    centerTitle: true,
    actions: const [
      Padding(
        padding: EdgeInsets.all(10.0),
        child: Icon(Icons.search, color: Colors.white),
      ),
    ],
  );
}
