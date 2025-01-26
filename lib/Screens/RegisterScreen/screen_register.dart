import 'package:chat_application_3/Screens/HomeScreen/screen_home.dart';
import 'package:chat_application_3/Screens/Login/Widgets/custom_form.dart';
import 'package:chat_application_3/Screens/Login/Widgets/rounded_button.dart';
import 'package:chat_application_3/Services/user_services.dart';
import 'package:flutter/material.dart';

class ScreenRegister extends StatefulWidget {
  const ScreenRegister({super.key});

  @override
  State<ScreenRegister> createState() => _ScreenRegisterState();
}

class _ScreenRegisterState extends State<ScreenRegister> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String? email, password, name;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
            key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomForm(
                  obsecureText: false,
                  hintText: "E-Mail",
                  onSaved: (newValue) {
                    email = newValue;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomForm(
                  obsecureText: true,
                  hintText: "Password",
                  onSaved: (newValue) {
                    password = newValue;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomForm(
                  obsecureText: false,
                  hintText: "Name",
                  onSaved: (newValue) {
                    name = newValue;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                RoundedButton(
                    color: Colors.teal,
                    onTap: () async {
                      if (_key.currentState!.validate()) {
                        _key.currentState!.save();
                        setState(() {
                          isLoading = true;
                        });
                        try {
                        final data =  await UserServices()
                              .registerUser(email!, password!, name!);
                       if(data){
                         Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => ScreenHome(),
                        ));
                       }
                       
                        } catch (e) {
                          setState(() {
                            isLoading = true;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString())));
                        }
                        

                       
                      }
                    },
                    text: "Register",
                    isLoading: isLoading),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already Have an Account "),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ))
                  ],
                )
              ],
            )),
      ),
    );
  }
}
