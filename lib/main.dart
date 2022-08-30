// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'gelismisStepper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      // ignore: prefer_const_constructors
      home: GelismisStepper(),
    );
  }
}

class BasicStepper extends StatefulWidget {
  const BasicStepper({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<BasicStepper> createState() => _BasicStepper();
}

class _BasicStepper extends State<BasicStepper> {
  int currentStep = 0;
  StepState? statestate = StepState.disabled;
  bool activeState = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
          child: Stepper(
        steps: allsteps(),
        currentStep: currentStep,
        onStepTapped: (value) {
          setState(() {
            currentStep = value;
          });
        },
        onStepContinue: () {
          setState(() {
            if (currentStep < allsteps().length - 1) {
              currentStep++;
            }

            if (currentStep == currentStep) {
              activeState = true;
            }
          });
        },
        onStepCancel: () {
          setState(() {
            if (currentStep > 0) {
              currentStep--;
            }
          });
        },
      )),
    );
  }

  List<Step> allsteps() {
    List<Step> allStepsList = [
      Step(
        title: Text(
          "Username Başlık",
          style: TextStyle(color: Colors.red),
        ),
        state: StepState.editing,
        subtitle: Text("Username Altbaşlık"),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Usurname label",
              hintText: "Usuername hint",
            ),
          ),
        ),
      ),
      Step(
        isActive: true,
        title: Text(
          "Mail Başlık",
          style: TextStyle(color: Colors.red),
        ),
        state: StepState.complete,
        subtitle: Text("Mail Altbaşlık"),
        content: TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Email",
            hintText: "Email hint",
          ),
        ),
      ),
      Step(
        isActive: activeState,
        title: Text(
          "Şifre Başlık",
          style: TextStyle(color: Colors.red),
        ),
        state: StepState.error,
        subtitle: Text("Şifre AltBaşlık"),
        content: TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Şifre",
            hintText: "Şifre Hint",
          ),
        ),
      ),
    ];

    return allStepsList;
  }
}
