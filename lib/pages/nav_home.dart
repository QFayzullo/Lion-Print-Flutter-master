import 'dart:convert';

import 'package:fase_rec/models/result.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../resurse/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavHome extends StatefulWidget {
  const NavHome({super.key});

  @override
  State<NavHome> createState() => _NavHomePageState();
}

var users = [];
var allUsersData = [];

Future<String> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token').toString();
  return token;
}

class _NavHomePageState extends State<NavHome> {
  Future<void> _getAllUsers() async {
    //get http://192.168.0.133:8008/employees
    final response = await http.get(
      Uri.parse('http://192.168.0.133:8008/employees'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${await getToken()}',
        'token': 'Bearer ${await getToken()}',
      },
    );
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      if (data['result'] != null) {
        setState(() {
          for (var i = 0; i < data['result'].length; i++) {
            allUsersData.add(Result.fromJson(data['result'][i]));
          }
        });
      } else {
        _showSnackBar("Ma'lumotlar topilmadi");
      }
    } else {
      _showSnackBar("Iltimos login va parolni tekshiring");
    }
  }

  _showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: MyColors.Myorange,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Row(
            children: [
              Text(
                "Lion",
                style: TextStyle(color: MyColors.Myorange),
              ),
              Text(
                "Print",
                style: TextStyle(color: MyColors.Myblack),
              ),
            ],
          ),
          backgroundColor: MyColors.Mygrey,
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: allUsersData.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(allUsersData[index].firstName),
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
