import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../Objects/calculation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../Providers/User.dart';

historyCheck(String? id,BuildContext context)async{
  if(id!=null){
    print(id);
    final url=Uri.parse('http://localhost:5000/history?id=996f8840-27a3-11ee-8088-a7e0762d97a1');
    var response = await http.get(url);
    if(response.statusCode==200) {
      var calcs=convert.jsonDecode(response.body) as Map<String, dynamic>;
      print(calcs.toString());
      try {
        calcs.forEach((key, value) {
          String? name, id;
          if(key=='username'){
            name=value;
          }
          else if(key=='userId'){
            id=value;
          }
          else if (key=='Calculations') {
            context.read<User>().historylist=[];
            value.forEach((k,v){
              double? inp1;
              double? inp2;
              String? operation;
              double? res;
              v.forEach((k2,v2){
                if(k2=='input1'){
                  inp1=v2;
                }
                else if(k2=='input2'){
                  inp2=v2;
                }
                else if(k2=='signOperation'){
                  operation=v2;
                }
                else if(k2=='result'){
                  res=v2;
                }
              });
              if(inp1!=null){
                try {
                  context.read<User>().historylist.add(Calculation(inp1!, inp2!, operation!, res!,name!,id!));
                } on Exception catch (e) {
                  print('Exception while adding to list: $e');
                }
              }
            });
          }
        });
      }
      on Exception catch (e) {
        print('BU error olu $e');
      }
    }
    else{
      print('Error receiving history. Error code: ${response.statusCode}');
    }
  }
  else{
    print('No id given, please provide some userID');
  }
}