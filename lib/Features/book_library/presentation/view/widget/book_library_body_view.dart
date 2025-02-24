import 'package:booky/Features/book_library/domain/entities/book_entity.dart';
import 'package:booky/Features/book_library/presentation/manager/cubit/book_library_cubit.dart';
import 'package:booky/Features/book_library/presentation/view/widget/book_list_view_section_one.dart';
import 'package:booky/Features/book_library/presentation/view/widget/custom_background_page.dart';
import 'package:booky/Features/book_library/presentation/view/widget/custom_book_image.dart';
import 'package:booky/Features/book_library/presentation/view/widget/loading_scroll.dart';
import 'package:booky/Features/book_library/presentation/view/widget/staggered_grid_view.dart';
import 'package:booky/core/constant/app_color.dart';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class BookLibraryBodyView extends StatefulWidget {
  BookLibraryBodyView({
    super.key,
    required this.books,
  });
  List<BookEntity> books = [];

  @override
  State<BookLibraryBodyView> createState() => _BookLibraryBodyViewState();
}

class _BookLibraryBodyViewState extends State<BookLibraryBodyView> {
  final ScrollController _scrollController = ScrollController();
  late BookLibraryCubit cubit;
  @override
  void initState() {
    cubit = BlocProvider.of<BookLibraryCubit>(context);
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  _onScroll() {
    FocusScope.of(context).requestFocus(FocusNode());
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      /* Increment one to fetch information (lazy Load) */
      cubit.fetchBooks(pageNumber: cubit.pageNumber++);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookLibraryCubit, BookLibraryState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Stack(children: [
          const CustomBackGroundPage(),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            widget.books.isEmpty
                ? const SizedBox.shrink()
                : BookListViewSectionOne(books: widget.books),
            const SizedBox(height: 50),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'All Books',
                style: TextStyle(
                  color: AppColor.primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            StaggeredGridView(
              scrollController: _scrollController,
              widget: widget,
              state: state,
            )
          ])
        ]);
      },
    );
  }
}

class _FlexibleSliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  _FlexibleSliverHeaderDelegate({required this.child});

  final Widget child;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 450.0;
  @override
  double get minExtent => 200.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
