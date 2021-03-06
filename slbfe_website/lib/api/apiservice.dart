import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:slbfe_website/global.dart' as global;
import 'package:slbfe_website/global.dart';
import 'package:slbfe_website/model/jsusermodel.dart';
import '../model/loginmodel.dart';

class APIService {
  Future login(LoginRequestModel requestModel, String userType) async {
    var headers = {'Content-Type': 'application/json'};
    var request =
        http.Request('POST', Uri.parse('${Urls.apiUrl}/api/Auth/login'));
    request.body = json.encode({
      "userID": requestModel.email,
      "password": requestModel.password,
      "userType": userType,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String res = await response.stream.bytesToString();
      print(res);
      global.email = requestModel.email;
      Auth.apiToken = res;
      return 1;
    } else {
      print(response.reasonPhrase);
      return -1;
    }

/*    String email = '';
    String password = '';
    http.Response response = await http.get(Uri.parse('${Urls.apiUrl}/api/Auth/login?userId=${requestModel.email}&password=${requestModel.password}&userType=$userType'));

    if (response.statusCode == 200) {
      print(response.statusCode);
      String data = response.body;
      print('data:$data');
      if (data == '[]') {
        print("Wrong password or email provided");
        print('0');
        return 0;
      } else {
        email = jsonDecode(data)[0]["UserID"];
        password = jsonDecode(data)[0]["Password"];
        print(email);
        print(password);
      }

      if (email == requestModel.email && password == requestModel.password) {
        global.email = email;
        print('Login Successfull!');
        print('email: $email');

        return 1;
      }
    } else {
      print(response.statusCode);
      print(response.reasonPhrase);
      print('Something went wrong');
      print('-1');
      return -1;
    }*/
  }

  static Future addJsUser(jsUserModel user) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('${Urls.apiUrl}/api/companies/register'));
    request.body = json.encode({
      "email": user.email,
      "password": user.password,
      "name": user.name,
      "companyName": user.companyName,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(response.statusCode);
      print(await response.stream.bytesToString());
      global.email = user.email;
      return true;
    } else {
      print(response.statusCode);
      print(response.reasonPhrase);
      return false;
    }
  }
}
