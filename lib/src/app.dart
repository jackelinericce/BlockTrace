import 'package:flutter/material.dart';
import 'package:stotppub/src/core/config/app_router.dart';
import 'package:stotppub/src/core/config/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: MyAppTheme.theme,
      routerConfig: appRouter,
    );
  }
}
