import 'dart:convert';
import 'dart:async';
import 'package:dlslim/Model/bottomnavbar.dart';
import 'package:dlslim/Model/model_profile.dart';
import 'package:dlslim/Model/model_verif.dart';
import 'package:dlslim/Pages/beauty_id.dart';
import 'package:dlslim/api/globals.dart' as globals;
import 'package:dlslim/api/globals.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPost {
  final String response;
  LoginPost({this.response});

  factory LoginPost.createJson(Map<String, dynamic> obj) {
    return LoginPost(
      response: obj['user_state'],
    );
  }
  static Future<LoginPost> loginPostTest(
      BuildContext context, String username, String password) async {
    var url = 'https://dlslimskincare.com/wp-json/remote-login/login';
    var apiResult = await http.post(url,
        body: json.encode({'username': username, 'password': password}),
        headers: {"Content-Type": "application/json"});
    var jsonObject = json.decode(apiResult.body) as Map;
    globals.gagalLogin = jsonObject;
    if (apiResult.statusCode == 200) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('response', apiResult.body);

      // Navigator.pushReplacementNamed(context, '/rumah');
      debugPrint(jsonObject.toString());
    } else {
      debugPrint(jsonObject['message']);
      globals.gagalMsk = jsonObject['message'] ?? '';
      globals.isLoginButtonDisabled = false;
    }
    return LoginPost.createJson(jsonObject);
  }
}

class Treat {
  static Future getList() async {
    final response = await http
        .get('https://dashboard.dlslimskincare.com/api/treatments/all');
    if (response.statusCode == 200) {
      globals.tre = json.decode(response.body);
    }
    return globals.tre;
  }
}

class Photo {
  static var url =
      'https://dashboard.dlslimskincare.com/api/profile/photo/uploader';
  static Future insertFoto(String userId, String imageDepan, String imagekanan,
      String imageKiri) async {
    var response = await http.post(
      url,
      body: {
        'user_id': userId,
        'depan_base64_image': imageDepan,
        'kanan_base64_image': imagekanan,
        'kiri_base64_image': imageKiri,
      },
    );
    // var getBody = json.decode(response.body) as Map;
    if (response.statusCode == 200) {
      Get.offAll(BeautyId());
      debugPrint(response.body);
    } else {
      Fluttertoast.showToast(msg: 'Harap periksa koneksi internet anda');
      debugPrint(response.body);
    }
  }

  static Future updateFoto(String userId, String imageDepan, String imagekanan,
      String imageKiri) async {
    var response = await http.post(
      url,
      body: {
        'user_id': userId,
        'depan_base64_image': imageDepan,
        'kanan_base64_image': imagekanan,
        'kiri_base64_image': imageKiri,
      },
    );
    // var getBody = json.decode(response.body) as Map;
    if (response.statusCode == 200) {
      Get.offAll(BottomNavBar());
      debugPrint(response.body);
    } else {
      Fluttertoast.showToast(msg: 'Harap periksa koneksi internet anda');
      debugPrint(response.body);
    }
  }
}

class RegistQue {
  static Future storeQues(
      {String userId,
      String gender,
      String conditionFace,
      String skinType,
      String skinProblem,
      String otherSkinProblem,
      String prevProduct}) async {
    var url = 'https://dashboard.dlslimskincare.com/api/profile';
    await http.post(url, body: {
      'user_id': userId,
      'gender': gender,
      'skin_type': skinType,
      'skin_problem': skinProblem,
      'other_skin_problem': otherSkinProblem,
      'prev_product': prevProduct
    }).then((http.Response response) {
      if (response.statusCode == 200) {
        Get.offAll(BottomNavBar());
        debugPrint(response.body);
      } else {
        debugPrint(response.body);
        Fluttertoast.showToast(msg: 'Check koneksi internet anda');
      }
    });
  }
}

class ProfileGet {
  static Future<ModelProfile> getProf({String userId}) async {
    var url = 'https://dashboard.dlslimskincare.com/api/profile/retreive';
    var response = await http.post(url, body: {'user_id': userId});
    var jsobObject = json.decode(response.body);
    if (response.statusCode == 200) {
      debugPrint(response.body);
    } else {
      debugPrint(response.body);
    }
    return ModelProfile.jsonObject(jsobObject);
  }
}

class UpdateAvatar {
  static Future avatarUpdate(String userId, {String pict}) async {
    var url = 'https://dlslimskincare.com/wp-json/edge/v1/profile/replace';
    var response = await http.post(url,
        body: {'user_id': userId, 'the-pict': pict, 'submit': 'true'});
    var res = json.decode(response.body) as Map;
    if (response.statusCode == 200) {
      debugPrint(response.body);
      // Fluttertoast.showToast(msg: null);

    } else {
      debugPrint(response.body);
    }
  }

  static Future upload(String userId, List<int> pict, String random) async {
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://dlslimskincare.com/wp-json/edge/v1/profile/replace'));
    request.fields.addAll({'user_id': userId, 'submit': 'true'});
    http.MultipartFile profileImage = http.MultipartFile.fromBytes(
        "the-pict", pict,
        filename: random + '.jpg', contentType: MediaType("image", "jpg"));
    request.files.add(profileImage);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Get.to(BottomNavBar());
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}

class GetProduct {
  static Future getSearch(
      BuildContext context, String name, String base64) async {
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
    var url =
        'http://dlslimskincare.com/wp-json/wcfmmp/v1/products/?search=$name';
    var response =
        await http.get(url, headers: {"Authorization": "Basic " + base64});
    if (response.statusCode == 200) {
      Get.back();
      pencarian = json.decode(response.body);
      debugPrint(response.body);
    } else {
      debugPrint(response.body);
      pencarian = json.decode(response.body);
    }
  }
}

class VerifyEmail {
  static Future<ModelVerif> verifySent({String email}) async {
    var headers = {
      'x-api-key': 'd1b46720b256ff6a478a806acc251047',
      'x-api-key-2': '5dc39cbb27756a22630f017acbfb4970'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://verify.dlslimskincare.com/sent-email-to'));
    request.fields.addAll({'theEmail': email});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    final result = await response.stream.bytesToString();
    final jsonOb = json.decode(result);
    if (response.statusCode == 200) {
      print(jsonOb);
    } else {
      print(response.reasonPhrase);
    }
    return ModelVerif.createJson(jsonOb);
  }
}

class FilterSearch {
  static Future filterSearch() async {
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://dashboard.dlslimskincare.com/products/list-category'));

    http.StreamedResponse response = await request.send();
    final result = await response.stream.bytesToString();
    globals.jsonFilter = json.decode(result);

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}
