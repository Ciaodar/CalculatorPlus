import 'package:http/http.dart' as http;
import 'dart:convert' as convert;


sendToDotNet(double firn,double secn, String op,String id,String name)async{
  final doturl=Uri.http('localhost:5254');
  try {
    Map<String,dynamic> body=
    {
      'username':name,
      'userId':id,
      'Calculations':
      [{
        'input1':firn,
        'input2':secn,
        'signOperation':op,
      }]
    };
    final response= await http.post(doturl,body:convert.jsonEncode(body));
    if(response.statusCode==200){
      print('Calculation request succesfully sent');
    }else{
      print('Calculation request failed. Error code:${response.statusCode}');
    }
  } on Exception catch (e) {
    print(e);
  }
}