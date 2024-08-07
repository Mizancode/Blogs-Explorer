import 'dart:convert';

import 'package:blog_explorer/Model/blog_model.dart';
import 'package:blog_explorer/Provider/favorite_list.dart';
import 'package:blog_explorer/Pages/blog_detail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class BlogsView extends StatefulWidget {
  const BlogsView({super.key});

  @override
  State<BlogsView> createState() => _BlogsViewState();
}

class _BlogsViewState extends State<BlogsView> {
  Future<BlogModelAPI> getModelAPI() async {
    const String url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
    const String adminSecret =
        '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'x-hasura-admin-secret': adminSecret},
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return BlogModelAPI.fromJson(data);
      } else {
        throw Exception('Resonse Error Occured...');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 15, top: 15),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Blogs\n & Articles',
                    style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'assets/fonts/Lato-Bold.ttf',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800),
                  ),
                  SizedBox(
                    width: size.width > 650 ? size.width * 0.5 : 30,
                  ),
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: 'Search Blogs...',
                          hintStyle: TextStyle(color: Colors.black),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1),
                            borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(40)),
                          )),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: FutureBuilder(
                    future: getModelAPI(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      } else if (snapshot.hasData) {
                        return size.width > 650
                            ? RefreshIndicator(
                                onRefresh: getModelAPI,
                                child: GridView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    padding: const EdgeInsets.only(right: 15),
                                    shrinkWrap: true,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            childAspectRatio: 2,
                                            crossAxisSpacing: 5),
                                    itemCount: snapshot.data!.blogs!.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    BlogDetailView(
                                                      title: snapshot.data!
                                                          .blogs![index].title
                                                          .toString(),
                                                      imageUrl: snapshot
                                                          .data!
                                                          .blogs![index]
                                                          .imageUrl
                                                          .toString(),
                                                    ))),
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 10),
                                          height: 250,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              image: DecorationImage(
                                                  image: NetworkImage(snapshot
                                                      .data!
                                                      .blogs![index]
                                                      .imageUrl
                                                      .toString()),
                                                  fit: BoxFit.fill)),
                                          child: Stack(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    gradient: LinearGradient(
                                                        colors: [
                                                          Colors.black
                                                              .withOpacity(0),
                                                          Colors.black
                                                              .withOpacity(0.7)
                                                        ],
                                                        begin: Alignment
                                                            .bottomRight,
                                                        end:
                                                            Alignment.topLeft)),
                                              ),
                                              Positioned(
                                                  top: 3,
                                                  left: 4,
                                                  right: 3,
                                                  child: Text(
                                                      snapshot.data!
                                                          .blogs![index].title
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize:
                                                              size.width > 1050
                                                                  ? 25
                                                                  : 18,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              'LatoRegular'),
                                                      maxLines: 2,
                                                      overflow: TextOverflow
                                                          .ellipsis)),
                                              Consumer<FavoriteList>(
                                                builder:
                                                    (context, value, child) {
                                                  return Positioned(
                                                      bottom: 0,
                                                      right: 0,
                                                      child: IconButton(
                                                        onPressed: () {
                                                          if (!value.list
                                                              .contains(snapshot
                                                                  .data!
                                                                  .blogs![index]
                                                                  .id)) {
                                                            value.addFavorite(
                                                                snapshot
                                                                    .data!
                                                                    .blogs![
                                                                        index]
                                                                    .id
                                                                    .toString());
                                                            value.addBlog(
                                                                snapshot.data!
                                                                        .blogs![
                                                                    index]);
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    const SnackBar(
                                                              content: Text(
                                                                  'Blog added in Favorite list...'),
                                                              duration:
                                                                  Duration(
                                                                      seconds:
                                                                          1),
                                                            ));
                                                          }
                                                        },
                                                        icon: Icon(
                                                          Icons.favorite,
                                                          size: 40,
                                                          color: value.list
                                                                  .contains(snapshot
                                                                      .data!
                                                                      .blogs![
                                                                          index]
                                                                      .id
                                                                      .toString())
                                                              ? Colors.red
                                                              : const Color
                                                                  .fromRGBO(251,
                                                                  252, 249, 1),
                                                        ),
                                                      ));
                                                },
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              )
                            : RefreshIndicator(
                                onRefresh: getModelAPI,
                                child: ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    padding: const EdgeInsets.only(right: 15),
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.blogs!.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    BlogDetailView(
                                                      title: snapshot.data!
                                                          .blogs![index].title
                                                          .toString(),
                                                      imageUrl: snapshot
                                                          .data!
                                                          .blogs![index]
                                                          .imageUrl
                                                          .toString(),
                                                    ))),
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 10),
                                          height: 250,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              image: DecorationImage(
                                                  image: NetworkImage(snapshot
                                                      .data!
                                                      .blogs![index]
                                                      .imageUrl
                                                      .toString()),
                                                  fit: BoxFit.fill)),
                                          child: Stack(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    gradient: LinearGradient(
                                                        colors: [
                                                          Colors.black
                                                              .withOpacity(0),
                                                          Colors.black
                                                              .withOpacity(0.7)
                                                        ],
                                                        begin: Alignment
                                                            .bottomRight,
                                                        end:
                                                            Alignment.topLeft)),
                                              ),
                                              Positioned(
                                                  top: 3,
                                                  left: 4,
                                                  right: 3,
                                                  child: Text(
                                                      snapshot.data!
                                                          .blogs![index].title
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              'LatoRegular'),
                                                      maxLines: 2,
                                                      overflow: TextOverflow
                                                          .ellipsis)),
                                              Consumer<FavoriteList>(
                                                builder:
                                                    (context, value, child) {
                                                  return Positioned(
                                                      bottom: 0,
                                                      right: 0,
                                                      child: IconButton(
                                                        onPressed: () {
                                                          if (!value.list
                                                              .contains(snapshot
                                                                  .data!
                                                                  .blogs![index]
                                                                  .id)) {
                                                            value.addFavorite(
                                                                snapshot
                                                                    .data!
                                                                    .blogs![
                                                                        index]
                                                                    .id
                                                                    .toString());
                                                            value.addBlog(
                                                                snapshot.data!
                                                                        .blogs![
                                                                    index]);
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    const SnackBar(
                                                              content: Text(
                                                                  'Blog added in Favorite list...'),
                                                              duration:
                                                                  Duration(
                                                                      seconds:
                                                                          1),
                                                            ));
                                                          }
                                                        },
                                                        icon: Icon(
                                                          Icons.favorite,
                                                          size: 40,
                                                          color: value.list
                                                                  .contains(snapshot
                                                                      .data!
                                                                      .blogs![
                                                                          index]
                                                                      .id
                                                                      .toString())
                                                              ? Colors.red
                                                              : const Color
                                                                  .fromRGBO(251,
                                                                  252, 249, 1),
                                                        ),
                                                      ));
                                                },
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              );
                      } else {
                        return const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.error,
                                size: 60,
                              ),
                              Text(
                                'Opps! Something Went Wrong.',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontFamily:
                                        'assets/fonts/Lato-Regular.ttf'),
                              )
                            ],
                          ),
                        );
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
