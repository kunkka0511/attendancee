import 'package:flutter/material.dart';
import 'package:slide_to_act/slide_to_act.dart';

class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  double screenHeight = 0;
  double screenWidth = 0;
  Color primary = Color(0xffeef44cc);
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 32),
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
              "Employee",
              style: TextStyle(
                fontFamily: "NexaBold",
                fontSize: screenWidth / 18,
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
                      "15:30",
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
                  text: "11",
                  style: TextStyle(
                    color: primary,
                  ),
                  children: [
                    TextSpan(
                        text: "jan 2023",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: screenWidth / 20,
                          fontFamily: "NexaBold",
                        ))
                  ]),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "20:00:01 PM",
              style: TextStyle(
                fontFamily: "NexaRegular",
                fontSize: screenWidth / 20,
                color: Colors.black54,
              ),
            ),
          ),
          Builder(builder: (context) {
            final GlobalKey<SlideActionState> key = GlobalKey();
            return const SlideAction(
              text: "Slide to Check in",
            );
          })
        ]),
      ),
    );
  }
}
