import 'package:attendance/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangePass extends StatefulWidget {
  @override
  _ChangePassState createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePass> {
  final _formkey = GlobalKey<FormState>();
  var newPassword = "";
  final newPassordController = TextEditingController();
  @override
  void dispose() {
    newPassordController.dispose();
    super.dispose();
  }

  final currentUser = FirebaseAuth.instance.currentUser;

  void changePassword() async {
    try {
      await FirebaseAuth.instance.currentUser!.updatePassword(newPassword);
      FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => loginPage()),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.black26,
          content: Text(
            'Your password has been changed. Please logi n again!',
          ),
        ),
      );
    } catch (error) {
      // Handle any error that occurs during password change
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formkey,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
          child: ListView(
            children: [
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Image(
                  image: AssetImage('assets/images/change.jpg'),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'New Password',
                    hintText: 'Enter mew Password',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.black26, fontSize: 15.0),
                  ),
                  controller: newPassordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Password';
                    }
                    return null;
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    setState(() {
                      newPassword = newPassordController.text;
                    });
                    changePassword();
                  }
                },
                child: const Text(
                  'Change Password',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
