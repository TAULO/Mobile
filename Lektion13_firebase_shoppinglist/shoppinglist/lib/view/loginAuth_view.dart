import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppinglist/model/ItemState.dart';
import 'package:shoppinglist/view/shopping_list_widget.dart';

import '../model/LoginState.dart';

class LoginAuthView extends StatefulWidget {
  LoginAuthView({Key? key}) : super(key: key);

  @override
  State<LoginAuthView> createState() => _LoginAuthViewState();
}

class _LoginAuthViewState extends State<LoginAuthView> {
  final GlobalKey<FormState> _globalKey = GlobalKey();

  String username = "";
  String email = "";
  String password = "";

  bool errorBol = false;
  String errorMessage = "";
  late Color messageColor;
  Align errorMessageText() {
    if (errorBol) {
      return Align(
        alignment: Alignment.center,
        child: Text(
          errorMessage,
          style: const TextStyle(color: Colors.redAccent),
        ),
      );
    } else {
      return const Align();
    }
  }

  bool signingUp = false;
  int state = 1;
  Padding usernameSignUp() {
    if (signingUp) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: TextFormField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: "username",
          ),
          textAlign: TextAlign.center,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please fill username";
            }
            return null;
          },
          onSaved: (newUsername) {
            if (newUsername != null) {
              username = newUsername;
            }
          },
        ),
      );
    } else {
      return const Padding(padding: EdgeInsets.zero);
    }
  }

  void handleSignUpEvent(User? signedInUser) async {
    {
      final form = _globalKey.currentState;
      if (form!.validate()) {
        form.save();
        // Future<String>? currentUser =
        // Provider.of<LoginState>(context, listen: false).createUserWithEmail(
        //     email: email, password: password, username: username);
        // String error = await currentUser;
        setState(() {
          // errorBol = true;
          // errorMessage = error;
          // messageColor = Colors.greenAccent;
          messageColor = Colors.redAccent;
        });
        String emailVal = email;
        String passwordVal = password;
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("login"),
              actions: [
                TextFormField(
                  initialValue: email,
                  textAlign: TextAlign.center,
                  onChanged: (val) {
                    setState(() {
                      emailVal = val;
                      print(emailVal);
                      print(email);
                      if (email != emailVal) {
                        errorMessage = "The credential does not match";
                        errorBol = true;
                        print(errorBol);
                      } else {
                        errorBol = false;
                        print(errorBol);
                      }
                    });
                  },
                  // validator: (val) {
                  //   if (emailVal != email) {
                  //     return "The credential does not match";
                  //   }
                  //   return null;
                  // },
                ),
                TextFormField(
                  initialValue: password,
                  textAlign: TextAlign.center,
                  obscureText: true,
                  validator: (val) {
                    if (val != password) {
                      return "The credential does not match";
                    }
                    return null;
                  },
                ),
                errorMessageText(),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () {
                      if (email != emailVal) {
                        setState(() {
                          errorMessage = "The credential does not match";
                          errorBol = true;
                        });
                      } else {
                        setState(() {
                          errorBol = false;
                        });
                      }
                    },
                    child: const Text("Login"),
                  ),
                ),
              ],
            );
          },
        );
      }
    }
  }

  void resetSignUpForm() {
    setState(() {
      state = 1;
      signingUp = false;
      errorBol = false;
      errorMessage = "";
    });
  }

  void resetAll(FormState form) {
    setState(() {
      form.reset();
      state = 1;
      signingUp = false;
      errorBol = false;
      errorMessage = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    User? signedInUser =
        Provider.of<LoginState>(context, listen: false).currentUser;

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Scaffold(
        backgroundColor: Colors.lightBlueAccent,
        body: Form(
          key: _globalKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              usernameSignUp(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 10,
                ),
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: "e-mail",
                    border: OutlineInputBorder(),
                  ),
                  textAlign: TextAlign.center,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please fill e-mail";
                    }
                    return null;
                  },
                  onSaved: (newEmail) {
                    if (newEmail != null) {
                      email = newEmail;
                    }
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                child: TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: "password",
                    hintStyle: TextStyle(),
                    border: OutlineInputBorder(),
                  ),
                  textAlign: TextAlign.center,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please fill password";
                    }
                    return null;
                  },
                  onSaved: (newPassword) {
                    if (newPassword != null) {
                      password = newPassword;
                    }
                  },
                ),
              ),
              errorMessageText(),
              ElevatedButton(
                onPressed: () async {
                  resetSignUpForm();
                  final form = _globalKey.currentState;
                  if (form!.validate()) {
                    form.save();
                    Future<String> currentUser =
                        Provider.of<LoginState>(context, listen: false)
                            .signInWithEmail(email: email, password: password);
                    Provider.of<ItemState>(context, listen: false)
                        .addItemsFromDB();
                    String error = await currentUser;
                    setState(() {
                      errorBol = true;
                      errorMessage = error.toString();
                      messageColor = Colors.redAccent;
                    });
                    if (signedInUser != null) {
                      resetAll(form);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShoppingListPage(),
                        ),
                      );
                    }
                  }
                },
                child: const Text("login"),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    signingUp = true;
                    state = 2;
                  });
                  if (state == 2) {
                    handleSignUpEvent(signedInUser);
                  }
                },
                child: const Text("sign up"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
