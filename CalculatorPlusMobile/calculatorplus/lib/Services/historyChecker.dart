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
        Uri.parse('https://plankton-app-kqhcg.ondigitalocean.app/api/cache?id=$id'),
        headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
    if(response.statusCode==200) {
      final jason=convert.jsonDecode(response.body);
      print(jason.toString());
      List<dynamic> calcobjsjson = jason[0]['Calculations'] as List;
      context.read<User>().historylist=
          calcobjsjson.map((calcjson) => Calculation.fromJson(json: calcjson)).toList();
    }
    else{
      print('Error receiving history. Error code: ${response.statusCode}');
    }
  }
  else{
    print('No id given, please provide some userID');
  }
}
