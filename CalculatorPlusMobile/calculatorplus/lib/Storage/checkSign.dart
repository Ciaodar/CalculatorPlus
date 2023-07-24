import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

import '../Providers/User.dart';


checkSign(BuildContext context)async{
  const storage = FlutterSecureStorage();
  Map<String,String> value = await storage.readAll();
  String? name;
  String? id;
  bool check=false;
  value.forEach((key, value) {
    if(key=='name'){
      name=value;
    }else if(key=='id'){
      id=value;
    }else if(key=='check'){
      check=(value=='true');
    }
  });
  if(id==null || name == null){
    Navigator.of(context).pushNamed('/sign');
  }
  context.read<User>().updateUserInfo(uid: id,checkedIn: check,name: name);
}