import 'package:calculatorplus/Storage/setStorage.dart';
import 'package:flutter/foundation.dart';
import 'package:web_socket_client/web_socket_client.dart';
import 'dart:convert' as convert;
import '../Objects/calculation.dart';

class User with ChangeNotifier {
  final socket =
  WebSocket(Uri.parse('ws://plankton-app-kqhcg.ondigitalocean.app'));
  User(){
    socket.messages.listen((message) {
      final jason = convert.jsonDecode(message);
      final id = jason['userId'];
      final username = jason['username'];
      List<dynamic> list = jason['Calculations'] as List;
      chatlist.addAll(list.map((calcjson) =>
          Calculation.fromJson(id: id, uname: username, json: calcjson)
      ));
      print("socket geldi");
      updateUserInfo(output: chatlist[chatlist.length-1].result.toString());
      notifyListeners();
    });
  }



  String? _output;
  String? _id;
  String? _name;
  bool _checkedIn=false;
  List<Calculation> _historylist=[
  ];

  List<Calculation> _chatlist=[
  ];


  String? get output => _output;

  set output(String? value) {
    _output = value;
  }

  List<Calculation> get historylist => _historylist;

  set historylist(List<Calculation> value) {
    _historylist = value;
    notifyListeners();
  }

  List<Calculation> get chatlist => _chatlist;

  set chatlist(List<Calculation> value) {
    _chatlist = value;
    notifyListeners();
  }

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

  void updateUserInfo({String? uid,String? output, String? name,bool? checkedIn,List<Calculation>? historylist,List<Calculation>? chatlist}) {
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
    if (output != null) {
      this._output = output;
    }
    notifyListeners();
  }//_output


}