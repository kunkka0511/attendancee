import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final email = FirebaseAuth.instance.currentUser!.email;
  final creationTime = FirebaseAuth.instance.currentUser!.metadata.creationTime;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 60.0),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Image(
              image: AssetImage('assets/images/profile.png'),
            ),
          ),
          SizedBox(height: 50.0),
          Column(
            children: [
              Text(
                'User Id',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Text(
                uid,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300),
              ),
            ],
          ),
          SizedBox(height: 50.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Email: $email',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Verify Email',
                  style: TextStyle(fontSize: 22.0, color: Colors.lightBlue),
                ),
              )
            ],
          ),
          SizedBox(
            height: 50.0,
          ),
          Column(
            children: [
              Text(
                'Created',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Text(
                creationTime.toString(),
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w300,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
