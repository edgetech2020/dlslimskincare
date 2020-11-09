import 'package:flutter/material.dart';

class DetailNews extends StatefulWidget {
  final NewsArguments arguments;
  DetailNews(this.arguments);

  @override
  _DetailNewsState createState() => _DetailNewsState();
}

class _DetailNewsState extends State<DetailNews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Text(widget.arguments.title),
            Text(widget.arguments.deskripsi),
            Image.network(widget.arguments.foto)
          ],
        ),
      ),
    );
  }
}

class NewsArguments {
  final String title;
  final String deskripsi;
  final String foto;

  NewsArguments(this.title, this.deskripsi, this.foto);
}
