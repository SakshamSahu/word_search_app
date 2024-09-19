import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_search_app/presentation/provider/search_provider.dart';
import 'package:word_search_app/utils/routes/app_routes.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => SearchProvider(),
    ),
  ], child: const WordSearchApp()));
}

class WordSearchApp extends StatelessWidget {
  const WordSearchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Word Search App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: AppRoutes.appRoutes,
      initialRoute: '/',
    );
  }
}
