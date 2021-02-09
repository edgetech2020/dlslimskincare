import 'package:dlslim/Model/appBar.dart';
import 'package:dlslim/Model/argument.dart';
import 'package:dlslim/style/extraStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

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
      extendBodyBehindAppBar: true,
      appBar: Appbar.getAppBar(context),
      body: Container(
        child: DraggableScrollableSheet(
          initialChildSize: 1.0,
          maxChildSize: 1.0,
          minChildSize: 0.7,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              decoration: BoxDecoration(
                  color: Color.fromRGBO(230, 248, 246, 1),
                  borderRadius: BorderRadius.circular(40)),
              child: ListView.builder(
                // scrollDirection: Axis.horizontal,
                controller: scrollController,
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.1,
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 1,
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: Image(
                          image: NetworkImage(widget.arguments.foto),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Center(
                          child: Container(
                        margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width * 0.1,
                          right: MediaQuery.of(context).size.width * 0.2,
                          left: MediaQuery.of(context).size.width * 0.2,
                        ),
                        child: Text(
                          widget.arguments.title,
                          style: ExtraStyle.styleHeading(),
                          textAlign: TextAlign.center,
                        ),
                      )),
                      Container(
                        margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width * 0.05,
                          right: MediaQuery.of(context).size.width * 0.05,
                          left: MediaQuery.of(context).size.width * 0.05,
                        ),
                        child: Html(
                          data: widget.arguments.deskripsi,
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
