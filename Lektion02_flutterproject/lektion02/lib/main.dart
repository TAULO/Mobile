import 'dart:async';
import 'dart:ffi';
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
  runApp(MaterialApp(home: Agent(agent: randomAgent)));
}

class Agent extends StatefulWidget {
  final String? agent;
  const Agent({Key? key, this.agent}) : super(key: key);

  @override
  State<Agent> createState() => _AgentState();
}

class _AgentState extends State<Agent> {
  String agent;
  _AgentState() : agent = "daniel_craig.png" {
    agent = randomAgent();
  }

  final agentList = [
    "daniel_craig.png",
    "george_lazenby.png",
    "pierce_brosnan.png",
    "roger_moore.png",
    "sean_connery.png",
    "timothy_dalton.png"
  ];

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        agent = randomAgent();
      });
    });
  }

  String randomAgent() {
    const agentList = [
      "daniel_craig.png",
      "george_lazenby.png",
      "pierce_brosnan.png",
      "roger_moore.png",
      "sean_connery.png",
      "timothy_dalton.png"
    ];
    Random rand = Random();
    var randomAgent = agentList[rand.nextInt(agentList.length)];
    // do {
    // var randomAgent = agentList[rand.nextInt(agentList.length)];
    // } while (randomAgent == agent) {
    //   return randomAgent;
    // }
    return randomAgent;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Double 007"),
        leading: IconButton(
          icon: const Icon(Icons.update),
          onPressed: () => {
            setState(() => {agent = randomAgent()})
          },
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(itemBuilder: (_, index)) => {
             Image.asset("assets/${agentList[0]}")}
        ),
      ),
    //   floatingActionButton: FloatingActionButton(
    //       backgroundColor: Colors.lightBlue,
    //       onPressed: () => setState(() {
    //             agent = randomAgent();
    //           }),
    //       child: const Text("Reload")),
    // );
  }
}
