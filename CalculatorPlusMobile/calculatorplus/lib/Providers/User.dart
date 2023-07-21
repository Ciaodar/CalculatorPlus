import 'package:calculatorplus/Storage/setStorage.dart';
import 'package:flutter/foundation.dart';

import '../Objects/calculation.dart';

class User with ChangeNotifier {
  User();
  String? _id;
  String? _name;
  bool _checkedIn=false;
  List<Calculation> historylist=[
    Calculation(10, 20, '+', 30,'Metehan','dskygfjsdbhvıusd'),
    Calculation(45, 20, '+', 65,'Metehan','dskygfjsdbhvıusd'),
    Calculation(23, 20, '+', 43,'Metehan','dskygfjsdbhvıusd'),
    Calculation(15, 20, '+', 35,'Metehan','dskygfjsdbhvıusd'),
    Calculation(76, 20, '+', 96,'Metehan','dskygfjsdbhvıusd'),
  ];

  List<Calculation> chatlist=[
    Calculation(10, 20, '+', 30,'Metehan','dskygfjsdbhvıusd'),
    Calculation(20, 5, '*', 100,'Burhan','buabsoljafbkbasd'),
    Calculation(50, 5, '/', 10,'Serdar','badhfasfkgvasfa'),
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