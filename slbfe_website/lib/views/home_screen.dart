import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'dart:convert';

import 'package:slbfe_website/views/complaints.dart';
import 'package:slbfe_website/views/profile.dart';
import 'package:slbfe_website/views/registration.dart';
import 'package:slbfe_website/views/search.dart';
import 'package:slbfe_website/views/signin.dart';
import 'package:slbfe_website/views/validate.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _selectedPage = 0;
  final PageController controller = PageController();

  Widget menuItem(String label, int index, IconData iconData){
    return Container(
      child: AspectRatio(
        aspectRatio: 3/2,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: InkWell(
            onTap: (){
              controller.jumpToPage(index);
              setState(() {
                _selectedPage = index;
              });
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                color: _selectedPage==index? Colors.indigo.shade200 : Colors.indigo.shade100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(iconData),
                    SizedBox(height: 3,),
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'SLBFE Admin Dashboard',
        ),
        elevation: 0,
        centerTitle: true,
        //backgroundColor: Colors.deepPurple.shade50,
      ),
      body: Container(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.blueGrey.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    children: [
                      menuItem("Profiles", 0, Icons.people),
                      menuItem("Validate", 1, Icons.check_circle),
                      menuItem("Complaints", 2, Icons.report_rounded),
                      menuItem("Search", 3, Icons.search),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 12,
              child: PageView(
                controller: controller,
                children: const <Widget>[
                  Profile(),
                  Validate(),
                  Complaints(),
                  Search(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
