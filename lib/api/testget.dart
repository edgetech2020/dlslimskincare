import 'dart:convert';

import 'package:dlslim/api/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

class TestGetApi {
  static Future getListCart(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            content: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
    try {
      final response = await http.get(
          'http://dlslimskincare.com/wp-json/cocart/v1/get-cart/customer/' +
              globals.idUser['user_id'].toString());
      if (response.statusCode == 200) {
        Get.back();
        globals.cart = json.decode(response.body) as Map;
        globals.cartId = globals.cart.values.toList();
      }
    } catch (e) {}
  }
}

class UserProfile {
  static Future userProfile() async {
    try {
      final response = await http.get(
          'https://dashboard.dlslimskincare.com/api/customers/' +
              globals.idUser['user_id'].toString());
      if (response.statusCode == 200) {
        debugPrint('get success');
        globals.userProfile = json.decode(response.body) as Map;
        // debugPrint(globals.userProfile['capture_filename'].toString());
        return globals.userPr =
            globals.userProfile['datas']['skin_concern'] as List;
      }
    } catch (e) {}
  }
}

class GetWhislist {
  static Future getWhistlist() async {
    try {
      final response = await http.get(
          "http://dlslimskincare.com/wp-json/edge/wishlist/v1/get/" +
              globals.idUser['user_id'].toString());
      if (response.statusCode == 200) {
        debugPrint('get whislist success');
        globals.whislistGet = json.decode(response.body);
      } else {
        debugPrint(response.body);
      }
    } catch (e) {}
  }

  static Future getColor(String productId) async {
    try {
      var url = 'https://dlslimskincare.com/wp-json/edge/wishlist/v1/trigger';
      await http.post(url, body: {
        'uid': globals.idUser['user_id'].toString(),
        'product_id': productId
      }).then((http.Response response) {
        if (response.statusCode == 200) {
          debugPrint('succes');
          debugPrint(response.body);
          globals.colorChange = json.decode(response.body);
        } else {
          debugPrint('gagal');
        }
      });
    } catch (e) {}
  }
}

class HistoryGet {
  static Future getHistory() async {
    try {
      var url = 'https://dashboard.dlslimskincare.com/api/orders_list';
      await http.post(url, body: {
        'status_r': 'any',
        'uid': globals.idUser['user_id'].toString(),
        'offset': ''
      }).then((http.Response response) {
        if (response.statusCode == 200) {
          debugPrint('success');
          globals.gethis = json.decode(response.body);
        } else {
          debugPrint('gagal');
        }
      });
    } catch (e) {}
  }

  static Future getHistoryP() async {
    try {
      var url = 'https://dashboard.dlslimskincare.com/api/orders_list';
      await http.post(url, body: {
        'status_r': 'pending',
        'uid': globals.idUser['user_id'].toString(),
        'offset': ''
      }).then((http.Response response) {
        if (response.statusCode == 200) {
          debugPrint('success');
          globals.gethisP = json.decode(response.body);
        } else {
          debugPrint('gagal');
        }
      });
    } catch (e) {}
  }

  static Future getHistoryM() async {
    try {
      var url = 'https://dashboard.dlslimskincare.com/api/orders_list';
      await http.post(url, body: {
        'status_r': 'processing',
        'uid': globals.idUser['user_id'].toString(),
        'offset': ''
      }).then((http.Response response) {
        if (response.statusCode == 200) {
          debugPrint('success');
          globals.gethisM = json.decode(response.body);
        } else {
          debugPrint('gagal');
        }
      });
    } catch (e) {}
  }

  static Future getHistoryS() async {
    try {
      var url = 'https://dashboard.dlslimskincare.com/api/orders_list';
      await http.post(url, body: {
        'status_r': 'completed',
        'uid': globals.idUser['user_id'].toString(),
        'offset': ''
      }).then((http.Response response) {
        if (response.statusCode == 200) {
          debugPrint('success');
          globals.gethisM = json.decode(response.body);
        } else {
          debugPrint('gagal');
        }
      });
    } catch (e) {}
  }

  static Future getHistoryB() async {
    try {
      var url = 'https://dashboard.dlslimskincare.com/api/orders_list';
      await http.post(url, body: {
        'status_r': 'cancelled',
        'uid': globals.idUser['user_id'].toString(),
        'offset': ''
      }).then((http.Response response) {
        if (response.statusCode == 200) {
          debugPrint('success');
          globals.gethisM = json.decode(response.body);
        } else {
          debugPrint('gagal');
        }
      });
    } catch (e) {}
  }
}
