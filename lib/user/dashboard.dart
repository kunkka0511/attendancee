import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:slide_to_act/slide_to_act.dart';

class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final email = FirebaseAuth.instance.currentUser!.email;
  final uid = FirebaseAuth.instance.currentUser!.uid;

  double screenHeight = 0;
  double screenWidth = 0;
  String checkIn = "--/--";
  String checkOut = "--/--";

  Color primary = const Color.fromARGB(251, 69, 21, 91);
  @override
  void initState() {
    super.initState();
    _getRecord();
  }

  void _getRecord() async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      print(auth.currentUser!.uid);
      var name = await FirebaseFirestore.instance
          .collection('Name')
          .doc(auth.currentUser!.uid)
          .get();
      Map<String, dynamic> data = name.data()!;

      var name2 = await FirebaseFirestore.instance
          .collection("Name")
          .doc(auth.currentUser!.uid)
          .collection("Record")
          .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
          .get();
      setState(() {
        checkIn = name2['checkIn'];
        checkOut = name2['checkOut'];
      });
    } catch (e) {
      setState(() {
        checkIn = "--/--";
        checkOut = "--/--";
      });
    }
  }

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
                      checkIn,
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
                      checkOut,
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
            stream: Stream.periodic(const Duration(seconds: 1)),
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
          checkOut == "--/--"
              ? Container(
                  margin: const EdgeInsets.only(top: 24),
                  child: Builder(builder: (context) {
                    final GlobalKey<SlideActionState> key = GlobalKey();
                    return SlideAction(
                      text: checkIn == "--/--"
                          ? "Slide to Check in"
                          : "Slide to Check Out",
                      textStyle: TextStyle(
                        color: Colors.black54,
                        fontSize: screenWidth / 20,
                        fontFamily: "NexaReguler",
                      ),
                      innerColor: primary,
                      key: key,
                      onSubmit: () async {
                        FirebaseAuth auth = FirebaseAuth.instance;
                        print(auth.currentUser!.uid);
                        var name = await FirebaseFirestore.instance
                            .collection('Name')
                            .doc(auth.currentUser!.uid)
                            .get();

                        
                        var name2 = await FirebaseFirestore.instance
                            .collection("Name")
                            .doc(auth.currentUser!.uid)
                            .collection("Record")
                            .doc(DateFormat('dd MMMM yyyy')
                                .format(DateTime.now()))
                            .get();

                        try {
                          String checkIn = name2['checkIn'];
                          setState(() {
                            checkOut =
                                DateFormat('hh:mm').format(DateTime.now());
                          });
                          await FirebaseFirestore.instance
                              .collection("Name")
                              .doc(auth.currentUser!.uid)
                              .collection("Record")
                              .doc(DateFormat('dd MMMM yyyy')
                                  .format(DateTime.now()))
                              .update({
                            'checkIn': checkIn,
                            'checkOut':
                                DateFormat('hh:mm').format(DateTime.now())
                          });
                        } catch (e) {
                          setState(() {
                            checkIn =
                                DateFormat('hh:mm').format(DateTime.now());
                          });
                          await FirebaseFirestore.instance
                              .collection("Name")
                              .doc(auth.currentUser!.uid)
                              .collection("Record")
                              .doc(DateFormat('dd MMMM yyyy')
                                  .format(DateTime.now()))
                              .set(
                            {
                              'checkIn': DateFormat('hh:mm').format(
                                DateTime.now(),
                              )
                            },
                          );
                        }
                      },
                    );
                  }),
                )
              : Container(
                  margin: const EdgeInsets.only(top: 32, bottom: 32),
                  child: Text(
                    "You have completed this day!",
                    style: TextStyle(
                      fontFamily: "NexaRegular",
                      fontSize: screenWidth / 20,
                      color: const Color.fromARGB(137, 15, 20, 97),
                    ),
                  ),
                ),
        ]),
      ),
    );
  }
}
