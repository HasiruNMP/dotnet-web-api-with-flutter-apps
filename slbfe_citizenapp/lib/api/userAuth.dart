import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/loginmodel.dart';
import 'dart:convert';
import 'dart:async';

class UserAuth with ChangeNotifier {

  static bool isLoggedIn = false;

  Future login(LoginRequestModel requestModel) async {
    String email = '';
    String password = '';
    int nic;
    http.Response response = await http.get(Uri.parse(
        'https://10.0.2.2:7018/api/JsUser/login?email=${requestModel.email}&password=${requestModel.password}'));

    if (response.statusCode == 200) {
      print(response.statusCode);
      String data = response.body;
      print('data:$data');
      if (data == '[]') {
        print("Wrong password or email provided");
        print('0');
        return 0;
      } else {
        nic = jsonDecode(data)[0]["NIC"];
        email = jsonDecode(data)[0]["Email"];
        password = jsonDecode(data)[0]["Password"];
        print(email);
        print(password);
      }

      if (email == requestModel.email && password == requestModel.password) {
        // global.nic = nic;
        print('Login Successfull!');
        print('Nic: $nic');

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('isLoggedIn', true);
        prefs.setString('userEmail', email);
        notifyListeners();

        return nic;
      }
    } else {
      print(response.statusCode);
      print(response.reasonPhrase);
      print('Something went wrong');
      print('-1');
      return -1;
    }
  }

}