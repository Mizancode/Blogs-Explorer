import 'package:blog_explorer/Provider/favorite_list.dart';
import 'package:blog_explorer/Pages/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const BlogExplorer());
}

class BlogExplorer extends StatelessWidget {
  const BlogExplorer({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoriteList()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            appBarTheme: const AppBarTheme(
                centerTitle: true,
                titleTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 25,
                    fontFamily: 'LatoBold'))),
        home: const Home(),
      ),
    );
  }
}
