import 'package:crud_app/view/homescreen.dart';
import 'package:crud_app/view/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  TextEditingController userNameCondroller = TextEditingController();
  TextEditingController passWoredCondroller = TextEditingController();
  String errorMassage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 140,
                ),
                const Icon(
                  Icons.lock_outline_rounded,
                  size: 100,
                  color: Colors.amber,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Log in to your account",
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255), fontSize: 20),
                ),
                const SizedBox(
                  height: 30,
                ),
                Form(
                    child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.name,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          labelText: "Username",
                          hintText: "Enter Your Username",
                          labelStyle: const TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255)),
                          prefixIcon: const Icon(
                            Icons.near_me,
                            color: Colors.amberAccent,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40.0),
                          )),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Form(
                        child: Column(
                      children: [
                        TextFormField(
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              labelText: "Password",
                              labelStyle: const TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255)),
                              hintText: "Enter Your Password",
                              prefixIcon: const Icon(
                                Icons.password,
                                color: Colors.amberAccent,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: const BorderSide(
                                      color: Colors.amberAccent))),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            log_in();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 255, 191, 0)),
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 18,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Forgot Password?",
                            style: TextStyle(color: Colors.amber),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't Have An Account?",
                              style: TextStyle(color: Colors.white),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (ctx) {
                                    return SignupPage();
                                  }));
                                },
                                child: const Text(
                                  "Sign Up !",
                                  style: TextStyle(
                                      color: Colors.amber, fontSize: 18),
                                ))
                          ],
                        )
                      ],
                    ))
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future log_in() async {
    String username = userNameCondroller.text.trim();
    String password = passWoredCondroller.text.trim();

    SharedPreferences prefes = await SharedPreferences.getInstance();

    String? savedUserName = prefes.getString('usarName');
    String? savedPassword = prefes.getString('password');

   

    if (username.isEmpty || password.isEmpty) {
     print(errorMassage = "Please enter both username and password");
    } else if (username == savedUserName && password == savedPassword) {
      await prefes.setBool("isLoggedIn", true);

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) {
        return HomeScreen();
      }));
    } else {
      errorMassage = "invalid username or password";
    }
  }
}
