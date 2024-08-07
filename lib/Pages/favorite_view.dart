import 'package:blog_explorer/Provider/favorite_list.dart';
import 'package:blog_explorer/Pages/blog_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteBlogs extends StatelessWidget {
  const FavoriteBlogs({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          title: const Text('Favorite Blogs'),
          automaticallyImplyLeading: false),
      body: Consumer<FavoriteList>(
        builder: (context, value, child) {
          return Container(
              padding: const EdgeInsets.all(10),
              child: size.width > 650
                  ? GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 2,
                              crossAxisSpacing: 5),
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: value.map.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BlogDetailView(
                                        title:
                                            value.map[index].title.toString(),
                                        imageUrl: value.map[index].imageUrl
                                            .toString(),
                                      ))),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            height: 250,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        value.map[index].imageUrl.toString()),
                                    fit: BoxFit.fill)),
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      gradient: LinearGradient(
                                          colors: [
                                            Colors.black.withOpacity(0),
                                            Colors.black.withOpacity(0.7)
                                          ],
                                          begin: Alignment.bottomRight,
                                          end: Alignment.topLeft)),
                                ),
                                Positioned(
                                    top: 3,
                                    left: 4,
                                    right: 3,
                                    child: Text(
                                        value.map[index].title.toString(),
                                        style: TextStyle(
                                            fontSize:
                                                size.width > 1050 ? 25 : 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'LatoRegular'),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis)),
                              ],
                            ),
                          ),
                        );
                      })
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: value.map.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BlogDetailView(
                                        title:
                                            value.map[index].title.toString(),
                                        imageUrl: value.map[index].imageUrl
                                            .toString(),
                                      ))),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            height: 250,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        value.map[index].imageUrl.toString()),
                                    fit: BoxFit.fill)),
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      gradient: LinearGradient(
                                          colors: [
                                            Colors.black.withOpacity(0),
                                            Colors.black.withOpacity(0.7)
                                          ],
                                          begin: Alignment.bottomRight,
                                          end: Alignment.topLeft)),
                                ),
                                Positioned(
                                    top: 3,
                                    left: 4,
                                    right: 3,
                                    child: Text(
                                        value.map[index].title.toString(),
                                        style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'LatoRegular'),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis)),
                              ],
                            ),
                          ),
                        );
                      }));
        },
      ),
    );
  }
}
