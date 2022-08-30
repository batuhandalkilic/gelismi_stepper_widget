import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class GelismisStepper extends StatefulWidget {
  const GelismisStepper({super.key});

  @override
  State<GelismisStepper> createState() => _GelismisStepperState();
}

class _GelismisStepperState extends State<GelismisStepper> {
  bool visibilityControl = true;
  int currenStep = 0;
  bool activeStep = false;
  StepState? stateBool = StepState.indexed;
  bool kahkah = false;

  //key list
  late GlobalKey<FormState> formKey;
  late GlobalKey<FormState> usurKey;
  late GlobalKey<FormState> sifreKey;
  late List<GlobalKey<FormState>> keyList = [usurKey, formKey, sifreKey];
  // Controller list
  late TextEditingController sifreController;
  late TextEditingController mailControler;
  late TextEditingController kullaniciController;
  late List<TextEditingController> controllerList = [
    kullaniciController,
    mailControler,
    sifreController
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sifreController = TextEditingController();
    mailControler = TextEditingController();
    kullaniciController = TextEditingController();
    formKey = GlobalKey<FormState>();
    usurKey = GlobalKey<FormState>();
    sifreKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Gelişmiş Stepper Uygulaması"),
        ),
        body: SingleChildScrollView(
          child: Stepper(
            steps: stepListYarat(),
            currentStep: currenStep,
            onStepTapped: (value) {
              setState(() {
                currenStep = value;
              });
            },
            onStepContinue: () {
              setState(() {
                for (var i = 0; i < stepListYarat().length; i++) {
                  if (stepContinueController(
                          i, keyList[i], controllerList[i]) &&
                      currenStep < stepListYarat().length - 1) {
                    currenStep++;
                  }
                }
              });
            },
            onStepCancel: () {
              setState(() {
                if (currenStep > 0) {
                  currenStep--;
                }
              });
            },
          ),
        ));
  }

  List<Step> stepListYarat() {
    List<Step> tumStepList = [
      Step(
        title: Text("User Title"),
        subtitle: Text("User Subtitle"),
        isActive: usurKey.currentState?.validate() ?? false,
        state: stepstate(0, usurKey, kullaniciController),
        /*  currenStep == 0
            ? StepState.editing
            : usurKey.currentState?.validate() ?? false
                ? StepState.complete
                : StepState.error, */
        content: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: usurKey,
            child: TextFormField(
              controller: kullaniciController,
              onChanged: (value) {
                kullaniciController.value = TextEditingValue(
                    text: value,
                    selection: TextSelection.collapsed(offset: value.length));
              },
              validator: (value) {
                if (value!.length < 6) {
                  return "6 harfden fazla olmalı";
                } else {
                  return null;
                }
              },
              autofocus: true,
              obscureText: visibilityControl,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        visibilityControl = !visibilityControl;
                      });
                    },
                    icon: visibilityControl
                        ? Icon(Icons.visibility_off)
                        : Icon(Icons.visibility),
                  ),
                  label: Text("Kullanıcı Adı "),
                  hintText: "Kullanıcı Adı",
                  border: OutlineInputBorder()),
            ),
          ),
        ),
      ),
      Step(
        title: Text("Mail Title"),
        subtitle: Text("Mail Subtitle"),
        isActive: formKey.currentState?.validate() ?? false,
        state: stepstate(1, formKey, mailControler),
        /* currenStep == 1
            ? StepState.editing
            : usurKey.currentState?.validate() ?? false
                ? StepState.complete
                : StepState.error, */
        content: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: TextFormField(
              controller: mailControler,
              onChanged: ((value) {
                mailControler.value = TextEditingValue(
                    text: value,
                    selection: TextSelection.collapsed(offset: value.length));
              }),
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                final bool isValid = EmailValidator.validate(value!);
                final bool a = false;
                if (isValid) {
                } else {
                  return "Geçerli Bir Mail Giriniz";
                }
              },
              decoration: InputDecoration(
                  labelText: "Mail Adresi giriniz",
                  // label: Text("Mail "),
                  hintText: "@hotmail.com",
                  border: OutlineInputBorder()),
            ),
          ),
        ),
      ),
      Step(
        title: Text("Şifre Title"),
        subtitle: Text("Şifre Subtitle"),
        isActive: sifreKey.currentState?.validate() ?? false,
        state: stepstate(2, sifreKey, sifreController),
        /* currenStep == 2
            ? StepState.editing
            : sifreKey.currentState?.validate() ?? false
                ? StepState.complete
                : StepState.error, */
        content: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Form(
            key: sifreKey,
            child: TextFormField(
              controller: sifreController,
              onChanged: (value) {
                sifreController.value = TextEditingValue(
                    text: value,
                    selection: TextSelection.collapsed(offset: value.length));
              },
              validator: (value) {
                if (value!.length < 6) {
                  return "Şifre 6 haneden fazla olmalı";
                } else {
                  return null;
                }
              },
              obscureText: visibilityControl,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        visibilityControl = !visibilityControl;
                      });
                    },
                    icon: visibilityControl
                        ? Icon(Icons.visibility_off)
                        : Icon(Icons.visibility),
                  ),
                  label: Text("Şifre "),
                  hintText: "Şifre",
                  border: OutlineInputBorder()),
            ),
          ),
        ),
      ),
    ];
    return tumStepList;
  }

  stepstate(int currenStepControl, GlobalKey<FormState> formState,
      TextEditingController control) {
    if (currenStep == currenStepControl && control.text.isEmpty) {
      return StepState.editing;
    } else if (currenStep != currenStepControl) {
      if (formState.currentState?.validate() == null) {
        return StepState.complete;
      }
      if (formState.currentState?.validate() != null) {
        if (formState.currentState!.validate() == true) {
          return StepState.complete;
        } else if (currenStep != currenStepControl &&
            formState.currentState?.validate() == false &&
            control.text.isEmpty) {
          return StepState.complete;
        } else if (currenStep != currenStepControl &&
            formState.currentState?.validate() == false) {
          return StepState.error;
        }
      }
    } else if (currenStep == currenStepControl &&
        formState.currentState?.validate() == true &&
        control.text.isNotEmpty) {
      return StepState.complete;
    } else if (currenStep == currenStepControl &&
        formState.currentState?.validate() == false &&
        control.text.isNotEmpty) {
      return StepState.error;
    }
  }

  stepContinueController(int currenStepControl, GlobalKey<FormState> formState,
      TextEditingController control) {
    if (currenStep == currenStepControl &&
        formState.currentState!.validate() == true &&
        control.text.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
