import 'package:http/http.dart' as http;
import 'dart:convert' as convert;


sendToDotNet(double firn,double secn, String op,String? id)async{
  final doturl=Uri.http('https://calculatornetnode.azurewebsites.net/api/Calculator');
  if (id!=null) {
    Map<String,dynamic> body=
    {
      //'username':name,
      'userId':id,
      'calculations':
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
  }
  else { //if(id==null)
    print('No id given, please provide some userID');
  }
}