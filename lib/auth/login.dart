import 'dart:convert';
import 'package:fase_rec/dashboards/homepage.dart';
import 'package:fase_rec/resurse/colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late final _userController = TextEditingController();
  late final _passwordController = TextEditingController();
  bool _validateUser = false;
  bool _validatePassword = false;
  bool _isLoading = false;

  void pushSample(){
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
  }

  Future<void> _login() async {
    final response = await http.post(
      Uri.parse('http://192.168.0.133:8008/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': _userController.text.toString(),
        'password': _passwordController.text.toString(),
      }),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      setState(() {
        _isLoading = true;
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final data = jsonDecode(response.body);
      prefs.setString('token', data['result']['token']);
      pushSample();
    } else {
      setState(() {
        _isLoading = false;
      });
      _showSnackBar("Iltimos login va parolni tekshiring");
    }
  }

  @override
  void initState() {
    super.initState();
    _isLoading = false;
    _userController.addListener(() {
      setState(() {});
    });
    _passwordController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: h * 0.3,
            child: Image.asset("images/login.png"),
          ),
          const Text(
            "Sign Up",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: MyColors.Myblue12,
            ),
          ),
          SizedBox(
            height: h * 0.02,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              height: h * 0.06,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color(0xFFE5E5E5),
              ),
              child: TextField(
                controller: _userController,
                cursorColor: MyColors.Myorange,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none),
                  hintText: 'Username',
                  contentPadding: const EdgeInsets.only(left: 12),
                  prefixIcon: const Icon(
                    Icons.person,
                    color: MyColors.Myblue12,
                  ),
                  suffixIcon: _validateUser
                      ? const Icon(
                    Icons.error,
                    color: MyColors.Myorange,
                  )
                      : null,
                ),
              ),
            ),
          ),
          SizedBox(
            height: h * 0.02,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              height: h * 0.06,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: MyColors.Mygrey,
              ),
              child: TextFormField(
                controller: _passwordController,
                cursorColor: MyColors.Myorange,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none),
                  hintText: 'Password',
                  contentPadding: EdgeInsets.only(left: 12),
                  suffixIcon: _validatePassword
                      ? const Icon(
                    Icons.error,
                    color: MyColors.Myorange,
                  )
                      : null,
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: MyColors.Myblue12,
                  ),
                ),
              ),
            ),
          ),
          const Spacer(),
          SizedBox(
            width: w * 0.9,
            height: h * 0.06,
            child: ElevatedButton(
              onPressed: _isLoading ? null : () {
                setState(() {
                  _validateUser = _userController.text.isEmpty;
                  _validatePassword = _passwordController.text.isEmpty;
                });
                if (!_validateUser && !_validatePassword) {
                  _isLoading = true;
                  _login();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _isLoading ? Colors.grey : MyColors.Myblue12,
              ),
              child: _isLoading ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black,
                ),
              )
                  : Text(
                "Login",
                style: TextStyle(color: _isLoading ? Colors.black : MyColors.Mywhite, fontSize: 18),
              ),
            ),
          ),
          SizedBox(
            height: h * 0.02,
          ),
        ],
      ),
    );
  }
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        width: MediaQuery.of(context).size.width * 0.9,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Icon(Icons.warning_amber),
            Text(message,style: TextStyle(color: MyColors.Myblack),),
          ],
        ),
        backgroundColor: MyColors.Mygrey,
        duration: const Duration(milliseconds: 1000),
        behavior: SnackBarBehavior.floating,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
      ),
    );
  }
}
