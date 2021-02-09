import 'package:dlslim/api/globals.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MHistory {
  static Container historiAll() {
    return Container(
        child: ListView.builder(
            itemCount: (gethis != null) ? gethis['data'].length : 1,
            itemBuilder: (BuildContext context, index) {
              if (gethis != null) {
                return Card(
                  child: Row(
                    children: [
                      Container(
                        width: width * 0.3,
                        height: height * 0.15,
                        decoration: BoxDecoration(
                            image:
                                DecorationImage(image: NetworkImage(imagenot))),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text((gethis['data'] != null)
                              ? gethis['data'][index]['line_items'][0]['name']
                              : 'Data tidak ditemukan'),
                          Text((gethis['data'] != null)
                              ? NumberFormat.currency(
                                      locale: 'id',
                                      symbol: 'Rp. ',
                                      decimalDigits: 0)
                                  .format(int.parse(gethis['data'][index]
                                          ['line_items'][0]['price']
                                      .toString()))
                              : 'Data tidak ditemukan'),
                          Text('Quantity : ' +
                              '${gethis['data'][index]['line_items'][0]['quantity']}'),
                          Text('Total pembayaran : ' +
                              'Rp. ' +
                              ((gethis['data'] != null)
                                  ? NumberFormat.currency(
                                          locale: 'id',
                                          symbol: 'Rp. ',
                                          decimalDigits: 0)
                                      .format(int.parse(gethis['data'][index]
                                              ['total']
                                          .toString()))
                                  : 'Null')),
                          Text('Status : ' +
                              "${gethis['data'][index]['status']}")
                        ],
                      )
                    ],
                  ),
                );
              } else
                return Container(
                  margin: EdgeInsets.only(top: height * 0.3),
                  child: Center(child: Text('Data Tidak Ada')),
                );
            }));
  }

  static Container historiProses() {
    return Container(
        child: ListView.builder(
            itemCount: (gethisP != null) ? gethisP['data'].length : 1,
            itemBuilder: (BuildContext context, index) {
              if (gethisP != null) {
                return Card(
                  child: Row(
                    children: [
                      Container(
                        width: width * 0.3,
                        height: height * 0.15,
                        decoration: BoxDecoration(
                            image:
                                DecorationImage(image: NetworkImage(imagenot))),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text((gethisP['data'] != null)
                              ? gethisP['data'][index]['line_items'][0]['name']
                              : 'Data tidak ditemukan'),
                          Text((gethisP['data'] != null)
                              ? NumberFormat.currency(
                                      locale: 'id',
                                      symbol: 'Rp. ',
                                      decimalDigits: 0)
                                  .format(int.parse(gethisP['data'][index]
                                          ['line_items'][0]['price']
                                      .toString()))
                              : 'Data tidak ditemukan'),
                          Text('Quantity : ' +
                              '${gethisP['data'][index]['line_items'][0]['quantity']}'),
                          Text('Total pembayaran : ' +
                              'Rp. ' +
                              ((gethisP['data'] != null)
                                  ? NumberFormat.currency(
                                          locale: 'id',
                                          symbol: 'Rp. ',
                                          decimalDigits: 0)
                                      .format(int.parse(gethisP['data'][index]
                                              ['total']
                                          .toString()))
                                  : 'Null')),
                          Text('Status : ' +
                              "${gethisP['data'][index]['status']}")
                        ],
                      )
                    ],
                  ),
                );
              } else
                return Container(
                  margin: EdgeInsets.only(top: height * 0.3),
                  child: Center(child: Text('Data Tidak Ada')),
                );
            }));
  }

  static Container historiMenunggu() {
    return Container(
        child: ListView.builder(
            itemCount: (gethisM != null) ? gethisM['data'].length : 1,
            itemBuilder: (BuildContext context, index) {
              if (gethisM != null) {
                return Card(
                  child: Row(
                    children: [
                      Container(
                        width: width * 0.3,
                        height: height * 0.15,
                        decoration: BoxDecoration(
                            image:
                                DecorationImage(image: NetworkImage(imagenot))),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text((gethisM['data'] != null)
                              ? gethisM['data'][index]['line_items'][0]['name']
                              : 'Data tidak ditemukan'),
                          Text((gethisM['data'] != null)
                              ? NumberFormat.currency(
                                      locale: 'id',
                                      symbol: 'Rp. ',
                                      decimalDigits: 0)
                                  .format(int.parse(gethisM['data'][index]
                                          ['line_items'][0]['price']
                                      .toString()))
                              : 'Data tidak ditemukan'),
                          Text('Quantity : ' +
                              '${gethisM['data'][index]['line_items'][0]['quantity']}'),
                          Text('Total pembayaran : ' +
                              'Rp. ' +
                              ((gethisM['data'] != null)
                                  ? NumberFormat.currency(
                                          locale: 'id',
                                          symbol: 'Rp. ',
                                          decimalDigits: 0)
                                      .format(int.parse(gethisM['data'][index]
                                              ['total']
                                          .toString()))
                                  : 'Null')),
                          Text('Status : ' +
                              "${gethisM['data'][index]['status']}"),
                          Text(msg ?? '')
                        ],
                      )
                    ],
                  ),
                );
              } else
                return Container(
                  margin: EdgeInsets.only(top: height * 0.3),
                  child: Center(child: Text('Data Tidak Ada')),
                );
            }));
  }

  static Container historiSelesai() {
    return Container(
        child: ListView.builder(
            itemCount: (gethisS != null) ? gethisS['data'].length : 1,
            itemBuilder: (BuildContext context, index) {
              if (gethisS != null) {
                return Card(
                  child: Row(
                    children: [
                      Container(
                        width: width * 0.3,
                        height: height * 0.15,
                        decoration: BoxDecoration(
                            image:
                                DecorationImage(image: NetworkImage(imagenot))),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text((gethisS['data'] != null)
                              ? gethisS['data'][index]['line_items'][0]['name']
                              : 'Data tidak ditemukan'),
                          Text((gethisS['data'] != null)
                              ? NumberFormat.currency(
                                      locale: 'id',
                                      symbol: 'Rp. ',
                                      decimalDigits: 0)
                                  .format(int.parse(gethisS['data'][index]
                                          ['line_items'][0]['price']
                                      .toString()))
                              : 'Data tidak ditemukan'),
                          Text('Quantity : ' +
                              '${gethisS['data'][index]['line_items'][0]['quantity']}'),
                          Text('Total pembayaran : ' +
                              'Rp. ' +
                              ((gethisS['data'] != null)
                                  ? NumberFormat.currency(
                                          locale: 'id',
                                          symbol: 'Rp. ',
                                          decimalDigits: 0)
                                      .format(int.parse(gethisS['data'][index]
                                              ['total']
                                          .toString()))
                                  : 'Null')),
                          Text('Status : ' +
                              "${gethisS['data'][index]['status']}"),
                        ],
                      )
                    ],
                  ),
                );
              } else
                return Container(
                  margin: EdgeInsets.only(top: height * 0.3),
                  child: Center(child: Text('Data Tidak Ada')),
                );
            }));
  }

  static Container historiBatal() {
    return Container(
        child: ListView.builder(
            itemCount: (gethisB != null) ? gethisB['data'].length : 1,
            itemBuilder: (BuildContext context, index) {
              if (gethisB != null) {
                return Card(
                  child: Row(
                    children: [
                      Container(
                        width: width * 0.3,
                        height: height * 0.15,
                        decoration: BoxDecoration(
                            image:
                                DecorationImage(image: NetworkImage(imagenot))),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text((gethisB['data'] != null)
                              ? gethisB['data'][index]['line_items'][0]['name']
                              : 'Data tidak ditemukan'),
                          Text((gethisB['data'] != null)
                              ? NumberFormat.currency(
                                      locale: 'id',
                                      symbol: 'Rp. ',
                                      decimalDigits: 0)
                                  .format(int.parse(gethisB['data'][index]
                                          ['line_items'][0]['price']
                                      .toString()))
                              : 'Data tidak ditemukan'),
                          Text('Quantity : ' +
                              '${gethisB['data'][index]['line_items'][0]['quantity']}'),
                          Text('Total pembayaran : ' +
                              'Rp. ' +
                              ((gethisB['data'] != null)
                                  ? NumberFormat.currency(
                                          locale: 'id',
                                          symbol: 'Rp. ',
                                          decimalDigits: 0)
                                      .format(int.parse(gethisB['data'][index]
                                              ['total']
                                          .toString()))
                                  : 'Null')),
                          Text('Status : ' +
                              "${gethisB['data'][index]['status']}"),
                        ],
                      )
                    ],
                  ),
                );
              } else
                return Container(
                  margin: EdgeInsets.only(top: height * 0.3),
                  child: Center(child: Text('Data Tidak Ada')),
                );
            }));
  }
}
