import 'dart:convert';

import 'package:dlslim/Model/shared.dart';
import 'package:dlslim/api/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pusher/pusher.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;

class Livechat extends StatefulWidget {
  @override
  _LivechatState createState() => _LivechatState();
}

class _LivechatState extends State<Livechat> {
  String messageAdmin = '';
  String messageUser = '';
  Event lastEvent;
  Channel channel;
  String lastConnectionState;
  var messageSend = TextEditingController();
  List<Widget> temp = [];
  String id = '';

  @override
  void initState() {
    super.initState();
    ShareAll.getUserID().then((value) {
      id = idUser['user_id'].toString();
      // print(idUser['user_id'].toString());
      initPusher();
      Pusher.connect(onConnectionStateChange: (x) async {
        if (mounted) {
          lastConnectionState = x.currentState;
          setState(() {});
        }
      }, onError: (x) {
        debugPrint('error : ' + x.message);
      });
      getData();
    });
  }

  Future sendMessage() async {
    var response = await http.post(
        Uri.parse('https://dashboard.dlslimskincare.com/chat/send'),
        body: {'_to_admin': messageSend.text, 'uid': '$id'});
  }

  Future<void> initPusher() async {
    try {
      await Pusher.init(
          "af838dc55a6ae7aad71f",
          PusherOptions(
            cluster: "ap1",
          ),
          enableLogging: true);
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  Future<void> getData() async {
    print('sampe sini');
    channel = await Pusher.subscribe('live-chat-channel');
    await channel.bind('live-chat-event-$id', (x) {
      if (mounted) {
        setState(() {
          lastEvent = x;
          var message = json.decode(lastEvent.data);
          if (message['_from_admin'] != null) {
            messageAdmin += message['_from_admin'] + '\n';
            temp.add(Padding(
              padding: const EdgeInsets.all(5.0),
              child: messageAdmins(messageAdm: message['_from_admin']),
            ));
          } else {
            messageAdmin = '';
          }
          print(lastEvent.data);
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    Pusher.disconnect();
    Pusher.unsubscribe('live-chat-channel');
    // channel.unbind('live-chat-event-1');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Live Chat'),
      ),
      body: Container(
        // color: Colors.black,
        height: height,
        width: width,
        child: Stack(
          children: [
            Column(
              // crossAxisAlignment: CrossAxisAlignment.end,
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: temp,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      alignment: Alignment.bottomCenter,
                      width: width * 95 / 100,
                      child: TextFormField(
                        controller: messageSend,
                        onFieldSubmitted: (val) async {
                          // messageUser += val + '\n';
                          temp.add(Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: messageUsers(message: val),
                          ));
                          await sendMessage();
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Hexcolor('#4C8CA7')),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Hexcolor('#4C8CA7')),
                                borderRadius: BorderRadius.circular(15)),
                            suffixIcon: IconButton(
                                icon: Icon(Icons.send),
                                onPressed: () async {
                                  messageUser += messageSend.text + '\n';
                                  temp.add(Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child:
                                        messageUsers(message: messageSend.text),
                                  ));
                                  await sendMessage();
                                  messageSend.text = '';
                                  setState(() {});
                                })),
                      ))),
            )
          ],
        ),
      ),
    );
  }

  Align messageUsers({String message}) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Container(
          width: width * 40 / 100,
          alignment: Alignment.centerRight,
          decoration: BoxDecoration(
              color: Colors.lightBlue,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              )),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '$message',
              textAlign: TextAlign.right,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }

  Align messageAdmins({String messageAdm}) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Container(
          width: width * 40 / 100,
          decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              )),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '$messageAdm',
              textAlign: TextAlign.left,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
