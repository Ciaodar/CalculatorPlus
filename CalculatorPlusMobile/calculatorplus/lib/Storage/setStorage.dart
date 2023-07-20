import '../Providers/User.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
setStorage(User user){
  final storage = FlutterSecureStorage();
  storage.write(key: 'id', value: user.uid);
  storage.write(key: 'name', value: user.name);
  storage.write(key: 'check', value: user.checkedIn.toString());
}