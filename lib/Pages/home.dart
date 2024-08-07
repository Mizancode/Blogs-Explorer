import 'package:blog_explorer/Pages/blogs_view.dart';
import 'package:blog_explorer/Pages/favorite_view.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentPage = 0;
  final list = [const BlogsView(), const FavoriteBlogs()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: list[currentPage],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.purple,
        currentIndex: currentPage,
        onTap: (value) {
          currentPage = value;
          setState(() {});
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorite'),
        ],
      ),
    );
  }
}
