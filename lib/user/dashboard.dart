import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final email = FirebaseAuth.instance.currentUser!.email;
  User? user = FirebaseAuth.instance.currentUser;
  double screenHeight = 0;
  double screenWidth = 0;
  Color primary = Color.fromARGB(252, 61, 23, 157);
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 32),
            child: Text(
              "Welcome",
              style: TextStyle(
                color: Colors.black54,
                fontFamily: "NexaRegular",
                fontSize: screenWidth / 20,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'Name: $email',
              style: TextStyle(
                fontFamily: "NexaBold",
                fontSize: screenWidth / 30,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 30),
            child: Text(
              "Today's Status",
              style: TextStyle(
                fontFamily: "NexaBold",
                fontSize: screenWidth / 18,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 32),
            height: 150,
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(2, 2),
                ),
              ],
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Container(
                        child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Check in",
                      style: TextStyle(
                          fontFamily: "NexaReguler",
                          fontSize: screenWidth / 20,
                          color: Colors.black54),
                    ),
                    Text(
                      "09;30",
                      style: TextStyle(
                        fontFamily: "NexaBold",
                        fontSize: screenWidth / 18,
                      ),
                    ),
                  ],
                ))),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Check Out",
                      style: TextStyle(
                          fontFamily: "NexaReguler",
                          fontSize: screenWidth / 20,
                          color: Colors.black54),
                    ),
                    Text(
                      "--/--",
                      style: TextStyle(
                        fontFamily: "NexaBold",
                        fontSize: screenWidth / 18,
                      ),
                    )
                  ],
                ))
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(
                  text: DateTime.now().day.toString(),
                  style: TextStyle(
                    color: primary,
                    fontSize: screenWidth / 20,
                    fontFamily: "NexaBold",
                  ),
                  children: [
                    TextSpan(
                        text: DateFormat(' MMMM yyyy').format(DateTime.now()),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: screenWidth / 20,
                          fontFamily: "NexaBold",
                        ))
                  ]),
            ),
          ),
          StreamBuilder(
            stream: Stream.periodic(Duration(seconds: 1)),
            builder: (context, snapshot) {
              return Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  DateFormat('hh:mm:ss a').format(DateTime.now()),
                  style: TextStyle(
                    fontFamily: "NexaRegular",
                    fontSize: screenWidth / 20,
                    color: Colors.black54,
                  ),
                ),
              );
            },
          ),
          Container(
            margin: const EdgeInsets.only(top: 24),
            child: Builder(builder: (context) {
              final GlobalKey<FormBuilderState> key = GlobalKey();

              return FormBuilder(
                key: key,
                child: FormBuilderTextField(
                  name: 'text',
                  onChanged: (val) {
                    print(val); // Print the text value write into TextField
                  },
                ),
              );
            }),
          )
        ]),
      ),
    );
  }
}
