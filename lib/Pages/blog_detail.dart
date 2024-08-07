import 'package:flutter/material.dart';

class BlogDetailView extends StatelessWidget {
  final String title;
  final String imageUrl;
  const BlogDetailView(
      {super.key, required this.title, required this.imageUrl});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog Detailed'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              title,
              style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'LatoRegular'),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 40,
            ),
            Image(
              image: NetworkImage(imageUrl),
              height: size.width > 780 ? 475 : 350,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
          ],
        ),
      ),
    );
  }
}
