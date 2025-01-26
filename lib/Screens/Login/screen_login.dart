import 'package:chat_application_3/Screens/Login/Widgets/custom_form.dart';
import 'package:chat_application_3/Screens/Login/Widgets/rounded_button.dart';
import 'package:chat_application_3/Screens/RegisterScreen/screen_register.dart';
import 'package:chat_application_3/Services/user_services.dart';
import 'package:flutter/material.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({super.key});

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  bool isLoading = false;
  String? email, password;
  GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.sizeOf(context).height*0.27,),
                Container(
                  width: 110,
                  height: 100,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://e7.pngegg.com/pngimages/647/460/png-clipart-computer-icons-open-person-family-icon-black-silhouette-black.png"))),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomForm(
                  obsecureText: false,
                  hintText: "E-mail",
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
                RoundedButton(
                    color: Colors.lime,
                    onTap: () async {
                      if (key.currentState!.validate()) {
                        key.currentState!.save();
                        setState(() {
                          isLoading = true;
                        });
                        try {
                          
                          await UserServices().signinUser(email!, password!);
                        } catch (e) {
                          setState(() {
                            isLoading = false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString())));
                        }
                      }
                    },
                    text: "Login",
                    isLoading: isLoading),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't Have an Account "),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ScreenRegister(),
                          ));
                        },
                        child: Text(
                          "Register",
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  
}
