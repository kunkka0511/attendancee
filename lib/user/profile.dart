import 'package:flutter/material.dart';
class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  double screenHeight = 0;
  double screenWidth = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 32),
            child: Text(
              "My attendance",
              style: TextStyle(
                color: Colors.black54,
                fontFamily: "NexaBold",
                fontSize: screenWidth / 20,
              ),
            ),)
          ],
        ),
        
      ),
    );
  }
}




  
