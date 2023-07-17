import 'package:flutter/material.dart';

import '../resurse/colors.dart';
class NavCamera extends StatefulWidget {
  const NavCamera({super.key});

  @override
  State<NavCamera> createState() => _CamPageState();
}

class _CamPageState extends State<NavCamera> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Row(
        children: [
          Text("Lion",style: TextStyle(color: MyColors.Myorange),),
          Text("Print",style: TextStyle(color: MyColors.Myblack),),
        ],
      ),
        backgroundColor: MyColors.Mygrey,),
      body: Container(
        color: MyColors.Mygrey,
      ),
    );

  }
}
