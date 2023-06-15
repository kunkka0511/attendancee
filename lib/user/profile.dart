import 'package:attendance/pages/login.dart';
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

  User? user = FirebaseAuth.instance.currentUser;

  Future<void> verifyEmail() async {
    if (user != null && !user!.emailVerified) {
      await user!.sendEmailVerification();
      print('Verification Email has been sent');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.black26,
          content: Text(
            'Verification Email has been sent',
            style: TextStyle(fontSize: 18.0, color: Colors.amber),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 60.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Image(
                image: AssetImage('assets/images/profile.png'),
              ),
            ),
            SizedBox(height: 30.0),
            Column(
              children: [
                const Text(
                  'User Id',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  uid,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300),
                ),
              ],
            ),
            SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Email: $email',
                  style: const TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.w300),
                ),
                user!.emailVerified
                    ? const Text(
                        'Verified',
                        style:
                            TextStyle(fontSize: 22.0, color: Colors.lightBlue),
                      )
                    : TextButton(
                        onPressed: () => {verifyEmail()},
                        child: const Text(
                          'Verify Email',
                          style: TextStyle(
                              fontSize: 22.0, color: Colors.lightBlue),
                        ),
                      )
              ],
            ),
            const SizedBox(
              height: 30.0,
            ),
            Column(
              children: [
                const Text(
                  'Created',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  creationTime.toString(),
                  style: const TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w300,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 30.0,
            ),
            ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => loginPage(),
                      ),
                      (route) => false);
                },
                child: const Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
