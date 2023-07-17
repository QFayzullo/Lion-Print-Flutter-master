import 'package:flutter/material.dart';

import '../resurse/colors.dart';
class NavSettings extends StatefulWidget {
  const NavSettings({super.key});

  @override
  State<NavSettings> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<NavSettings> {
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
