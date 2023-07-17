import 'package:flutter/material.dart';

import '../resurse/colors.dart';
class NavReport extends StatefulWidget {
  const NavReport({super.key});

  @override
  State<NavReport> createState() => _ReportPageState();
}

class _ReportPageState extends State<NavReport> {
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
