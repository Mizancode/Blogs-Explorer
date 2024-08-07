import 'package:blog_explorer/Model/blog_model.dart';
import 'package:flutter/material.dart';

class FavoriteList extends ChangeNotifier {
  List<String> list = [];
  List<Blogs> map = [];

  void addBlog(Blogs mp) {
    map.add(mp);
    notifyListeners();
  }

  void removeBlog(Blogs mp) {
    map.remove(mp);
    notifyListeners();
  }

  void addFavorite(String id) {
    list.add(id);
    notifyListeners();
  }

  void removeFavorite(String id) {
    list.remove(id);
    notifyListeners();
  }
}
