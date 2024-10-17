import 'package:crud_app/view/homescreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController passwordCondroller = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    sing_up();
  }

  String errorMesssage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 250,
                ),
                const Text(
                  "Sign Up",
                  style: TextStyle(color: Colors.amber, fontSize: 25),
                ),
                const SizedBox(
                  height: 50,
                ),
                Form(
                  // Single Form wrapping both text fields
                  child: Column(
                    children: [
                      TextFormField(
                        controller:
                            usernameController, // Controller for username
                        keyboardType: TextInputType.name,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: "Username",
                          labelStyle: const TextStyle(color: Colors.white),
                          hintText: "Enter Your Username",
                          prefixIcon: const Icon(
                            Icons.near_me_rounded,
                            color: Colors.amber,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40)),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller:
                            passwordCondroller, // Controller for password
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle: const TextStyle(color: Colors.white),
                          prefixIcon: const Icon(
                            Icons.password,
                            color: Colors.amber,
                          ),
                          hintText: "Enter Your Password",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40)),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          sing_up();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber),
                        child: const Text(
                          "Submit",
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 18),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Log in",
                              style:
                                  TextStyle(color: Colors.amber, fontSize: 20),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future sing_up() async {
    String userName = usernameController.text.trim();
    String passWord = passwordCondroller.text.trim();

    if (userName.isEmpty || passWord.isEmpty) {
      setState(() {
        errorMesssage = 'Please enter both username and password';
      });
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('usarName', userName);
      await prefs.setString('password', passWord);
      await prefs.setBool("isLoggedIn", true);

      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) {
        return const HomeScreen();
      }));
    }
  }
}
