import 'package:flutter/material.dart';

class DetailNews extends StatefulWidget {
  final ScreenArguments arguments;
  DetailNews(this.arguments);

  @override
  _DetailNewsState createState() => _DetailNewsState();
}

class _DetailNewsState extends State<DetailNews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

class ScreenArguments {
  final String id;
  final String name;
  final String foto;
  final String harga;
  final double rating;
  final String deskripsi;

  ScreenArguments(
      this.id, this.name, this.foto, this.harga, this.rating, this.deskripsi);
}
