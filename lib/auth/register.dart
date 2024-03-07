import 'package:flutter/material.dart';
import 'package:todo_c10_monday/firebase/firebase_functions.dart';
import 'package:todo_c10_monday/home/home.dart';

class RegisterTab extends StatelessWidget {
  RegisterTab({super.key});

  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var userNameController = TextEditingController();
  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            SizedBox(
              height: 12,
            ),
            TextFormField(
              controller: userNameController,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Username required";
                }
                return null;
              },
              decoration: InputDecoration(
                label: Text("Username"),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Email required";
                }
                bool emailValid = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.com+")
                    .hasMatch(value);
                if (!emailValid) {
                  return "Please write email valid ex: xx@xx.com";
                }
                return null;
              },
              decoration: InputDecoration(
                label: Text("Email"),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            TextFormField(
              controller: phoneController,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Phone required";
                }
                return null;
              },
              decoration: InputDecoration(
                label: Text("Phone"),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Password required";
                }
                if (value.length < 6) {
                  return "password should be at least 6 char";
                }
                return null;
              },
              decoration: InputDecoration(
                label: Text("Password"),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    FirebaseFunctions.createUserAccount(
                        email: emailController.text,
                        password: passwordController.text,
                        phone: phoneController.text,
                        userName: userNameController.text,
                        onSuccess: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, HomeScreen.routeName, (route) => false);
                        },
                        onError: (errorMessage) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Error"),
                                content: Text(errorMessage),
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {}, child: Text("Okay")),
                                  ElevatedButton(
                                      onPressed: () {}, child: Text("Cacnel"))
                                ],
                              );
                            },
                          );
                        });
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: Text(
                  "Register",
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
