import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  const agentList = [
    "daniel_craig.png",
    "george_lazenby.png",
    "pierce_brosnan.png",
    "roger_moore.png",
    "sean_connery.png",
    "timothy_daltion.png"
  ];

  Random rand = Random();
  var randomAgent = agentList[rand.nextInt(agentList.length)];

  runApp(Agent(agent: randomAgent));
}

class Agent extends StatelessWidget {
  final String? agent;

  Agent(this.agent);

  @override
  Widget build(BuildContext context) {
    // return agent != null ? Image.asset('assets/$agent');
  }
}
