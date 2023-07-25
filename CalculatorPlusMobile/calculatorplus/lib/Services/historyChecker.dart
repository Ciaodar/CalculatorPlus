import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../Objects/calculation.dart';
import 'dart:convert' as convert;

import '../Providers/User.dart';

historyCheck(String? id,BuildContext context)async{
  if(id!=null){
    print(id);
    //final url=Uri.https('king-prawn-app-y7gi7.ondigitalocean.app','/history',{'id':'64b3f50f2b0cd7d0071d33f0'});
    var response = await http.get(
        Uri.parse('https://oyster-app-ufjzj.ondigitalocean.app/api/history?id=$id'),
        headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
    if(response.statusCode==200) {
      var json=convert.jsonDecode(response.body);
      print(json.toString());
      var calcobjsjson = json['Calculations'] as List;
      String? id=json['userId'];
      String? name=json['username'];
      context.read<User>().historylist =
          calcobjsjson.map((calcjson) => Calculation.fromJson(calcjson)).toList();
    }
    else{
      print('Error receiving history. Error code: ${response.statusCode}');
    }
  }
  else{
    print('No id given, please provide some userID');
  }
}