import 'package:calculatorplus/Storage/setStorage.dart';
import 'package:flutter/foundation.dart';
import 'package:web_socket_client/web_socket_client.dart';
import 'dart:convert' as convert;
import '../Objects/calculation.dart';

class User with ChangeNotifier {
  final socket =
  WebSocket(Uri.parse('ws://oyster-app-ufjzj.ondigitalocean.app'));
  User(){
    socket.messages.listen((message) {
      final jason = convert.jsonDecode(message);
      final id = jason['userId'];
      final username = jason['username'];
      final jas2 = convert.jsonDecode(jason['Calculations']);
      final inp1 = jas2['input1'] as double;
      final inp2 = jas2['input2'] as double;
      final res = jas2['result'] as double;
      final op = jas2['signOperation'] as String;
      chatlist.add(Calculation(
          name: username,
          id: id,
          input1: inp1,
          input2: inp2,
          operation: op,
          result: res));
    });
  }




  String? _id;
  String? _name;
  bool _checkedIn=false;
  List<Calculation> historylist=[
  ];

  List<Calculation> chatlist=[
  ];


  bool get checkedIn => _checkedIn;
  set checkedIn(bool value) {
    _checkedIn = value;
    notifyListeners();
  }

  String? get uid => _id;
  set uid(String? value) {
    _id = value;
    notifyListeners();
  }

  String? get name => _name;
  set name(String? value) {
    _name = value;
    notifyListeners();
  }


  // Other methods and functionalities
  void resetUser(){
    _id=null;
    _name=null;
    _checkedIn=false;
    historylist=[];
    chatlist=[];
    setStorage(this);
    notifyListeners();
  }

  void updateUserInfo({String? uid, String? name,bool? checkedIn,List<Calculation>? historylist,List<Calculation>? chatlist}) {
    if (uid != null) {
      _id = uid;
    }
    if (name != null) {
      _name = name;
    }
    if (checkedIn != null) {
      _checkedIn = checkedIn;
    }
    if (historylist != null) {
      this.historylist = historylist;
    }
    if (chatlist != null) {
      this.chatlist = chatlist;
    }
    notifyListeners();
  }
}