import 'package:dlslim/Model/appBar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductDemo extends StatefulWidget {
  @override
  _ProductDemoState createState() => _ProductDemoState();
}

class _ProductDemoState extends State<ProductDemo> {
  bool _hasMore;
  int _pageNumber;
  bool _error;
  bool _loading;
  final int _defaultPhotosPerPageCount = 10;
  List<Products> _produk;
  final int _nextPageThreshold = 5;

  @override
  void initState() {
    super.initState();
    _hasMore = true;
    _pageNumber = 1;
    _error = false;
    _loading = true;
    _produk = [];
    fetchProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar.getAppBar(context),
      body: getBody(),
    );
  }

  Widget getBody() {
    if (_produk.isEmpty) {
      if (_loading) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularProgressIndicator(),
          ),
        );
      } else if (_error) {
        return Center(
            child: InkWell(
          onTap: () {
            setState(() {
              _loading = true;
              _error = false;
              fetchProduct();
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text("Error while loading photos, tap to try agin"),
          ),
        ));
      }
    } else {
      return ListView.builder(
          itemCount: _produk.length + (_hasMore ? 1 : 0),
          itemBuilder: (BuildContext context, index) {
            if (index == _produk.length - _nextPageThreshold) {
              fetchProduct();
            }
            if (index == _produk.length) {
              if (_error) {
                return Center(
                    child: InkWell(
                  onTap: () {
                    setState(() {
                      _loading = true;
                      _error = false;
                      fetchProduct();
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text("Error while loading photos, tap to try agin"),
                  ),
                ));
              } else {
                return Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: CircularProgressIndicator(),
                ));
              }
            }
            final Products product = _produk[index];
            return Card(
              child: Column(
                children: [Text(product.title), Text(product.price)],
              ),
            );
          });
    }
    return Container();
  }

  Future<void> fetchProduct() async {
    try {
      final response = await http.get(
          'https://dashboard.dlslimskincare.com/api/products?_page=$_pageNumber');
      List<Products> product = Products.parseList(json.decode(response.body));
      setState(() {
        _hasMore = product.length == _defaultPhotosPerPageCount;
        _loading = false;
        _pageNumber = _pageNumber + 1;
        _produk.addAll(product);
      });
    } catch (e) {
      setState(() {
        _loading = false;
        _error = false;
      });
    }
  }
}

class Products {
  String title;
  String price;
  String deskripsi;

  Products(this.title, this.price, this.deskripsi);

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(json['name'], json['price'], json['description']);
  }
  static List<Products> parseList(List<dynamic> list) {
    return list.map((i) => Products.fromJson(i)).toList();
  }
}
