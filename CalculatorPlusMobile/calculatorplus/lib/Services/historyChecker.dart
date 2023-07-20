import '../Objects/calculation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

historyCheck(String? id)async{
  if(id!=null){
    final url=Uri.http('https://king-prawn-app-y7gi7.ondigitalocean.app/history?id=$id');
    var response = await http.get(url);
    if(response.statusCode==200) {
      var calcs=convert.jsonDecode(response.body) as Map<String, dynamic>;
      try {
        calcs.forEach((key, value) {
          if (key=='Calculations') {
            calcslist=[];
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
                calcslist.add(Calculation(inp1!, inp2!, operation!, res!));
              }
            });
          }
        });
      } on Exception catch (e) {
        print(e);
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