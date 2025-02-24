import 'package:booky/Features/book_library/presentation/view/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchBook extends StatelessWidget {
  const SearchBook({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customSearchAppBar(context,),
    );
  }
}
