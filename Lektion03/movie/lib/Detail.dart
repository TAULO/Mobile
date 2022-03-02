import 'package:flutter/material.dart';

import 'movie.dart';

class Detail extends StatelessWidget {
  // final Movie movie;

  const Detail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edge of Tomorrow"),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Container(
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(5.0, 5.0),
                        blurRadius: 10.0,
                        spreadRadius: 2.0),
                    BoxShadow(
                        color: Colors.white,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 0.0,
                        spreadRadius: 0.0),
                  ],
                ),
                child: Image.asset("assets/images/Edge of Tomorrow.jpg"),
                width: 220.0,
              ),
              Column(
                children: [
                  Text(
                    "2014, USA, Canada",
                    style: TextStyle(height: 2),
                  ),
                  Text(
                    "Action, SCI-FI, 113 min",
                    style: TextStyle(height: 2),
                  ),
                  Text(
                    "11 wins & 37 nominations",
                    style: TextStyle(height: 2),
                  )
                ],
              ),
            ],
          ),
          Row(
            children: [
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: const Text("Director"),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Text(
                      "Doug Liman",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ],
          ),
          Column(
            children: [
              Padding(padding: EdgeInsets.all(10.0)),
              const Text("Actors:"),
              Text("Tom Cruise, Emiliy Blunt, Brendan Gleeson, Bill Paxton",
                  style: TextStyle(fontWeight: FontWeight.bold))
            ],
          ),
          const Divider(
            color: Colors.black,
          ),
          Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Text(
                    "helloooooooooohelloooooooooohelloooooooooohelloooooooooo"),
              )
            ],
          )
        ],
      ),
    );
  }
}
