import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../components/my_textfield.dart';
import '../components/my_button.dart';
import '../components/square_tile.dart';


class LoginPage extends StatefulWidget {
    LoginPage({super.key});

    @override
    State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
    // text editing controllers
    final usernameController = TextEditingController();

    final passwordController = TextEditingController();

    void signUserIn() async {
        // show loading indicator
        showDialog(
            context: context, 
            builder: (context) {
                return const Center( 
                    child: CircularProgressIndicator(),
                );
            }
        );

        // try sign in
        try {
            await FirebaseAuth.instance.signInWithEmailAndPassword(
                email: usernameController.text,
                password: passwordController.text,
            ); 
             // pop the loading indicator
            Navigator.pop(context);

        } on FirebaseAuthException catch (e) {
            // pop the loading indicator
            Navigator.pop(context);

            if (e.code == 'user-not-found') {
                unableLogin("User not found");
            } else if (e.code == 'wrong-password') {
                unableLogin("Wrong password");
            } else {
                unableLogin("Unable to log in");
            }
        }  

    }

    // message popup
    void unableLogin(String message) {
        showDialog(
            context: context, 
            builder: (context) {
                return AlertDialog(
                    title: Text(message),
                );
            }
        );
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
        // appBar: AppBar(
        //     title: Text('Login'),
        // ),

        // safe area makes sure to avoid the screen notch
        body: SafeArea(
            child: Center(
                child: SingleChildScrollView(
                  child: Column(
                      children: [
                          // logo
                          // TODO (mtourne): couldn't make the svg format work. used PNG
                          // SvgPicture.asset('assets/icons/logo_large-optimized.svg'), 
                          Image.asset(
                              'assets/icons/logo_large.png', 
                              height: 150,
                          ),
                          const SizedBox(height: 40),
                
                          // welcome back
                          const Text(
                              "Welcome Back. We missed you!", 
                              style: TextStyle(
                                  fontSize: 16,
                              ),
                          ),
                          const SizedBox(height: 25),
                
                          // username / password  fields
                          MyTextField(
                              controller: usernameController,
                              hintText: 'Username',
                          ),
                          const SizedBox(height: 10),
                
                          MyTextField(
                              controller: passwordController,
                              hintText: 'Password',
                              obscureText: true,
                          ),
                          const SizedBox(height: 10),
                
                
                          // forgot password
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                    Text("Forgot Password?",
                                    style: TextStyle(color: Colors.grey[600]),
                                    ),
                            ],),
                          ),
                    
                          const SizedBox(height: 25),
                
                          // log in button
                          MyButton(
                              text: "Log in",
                              onTap: signUserIn,
                          ),
                          const SizedBox(height: 40),
                
                          // or continue with google / apple sign in.
                          Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  thickness: 0.5,
                                  color: Colors.grey[400],
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text('Or continue with', 
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              ),

                              Expanded(
                                child: Divider(
                                  thickness: 0.5,
                                  color: Colors.grey[400],
                                ),
                              ),

                            ],
                          ),
                          const SizedBox(height: 40),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                SquareTile(imagePath: 'assets/icons/google.png'),
                                SizedBox(width: 10),
                                SquareTile(imagePath: 'assets/icons/apple.png'),
                          ],),

                          const SizedBox(height: 40),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center ,
                            children: [
                            Text('Not a member?'),
                            SizedBox(width: 10),
                            Text('Register now', style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold)),
                          ],)
                
                          // not a member? sign up
                      
                      ],
                  ),
                ), 
            ),
        ),
        );
    }
} 