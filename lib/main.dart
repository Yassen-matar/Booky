import 'package:bloc/bloc.dart';
import 'package:booky/core/constant/observer.dart';
import 'package:booky/core/function/git_it.dart';
import 'package:booky/core/function/router.dart';
import 'package:booky/core/theme/theme_data.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  runApp(const MyApp());
/* init cubit with git_it */
  await initCubit();
  Bloc.observer = SimpleBlocObserver();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: CustomThemeData.lightTheme,
    );
  }
}
