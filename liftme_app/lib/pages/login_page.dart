import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../components/my_textfield.dart';
import '../components/my_button.dart';


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
        appBar: AppBar(
            title: Text('Login'),
        ),

        // safe area makes sure to avoid the screen notch
        body: SafeArea(
            child: Center(
                child: Column(
                    children: [
                        SizedBox(height: 50),
                        // logo
                        // TODO (mtourne): couldn't make the svg format work. used PNG
                        // SvgPicture.asset('assets/icons/logo_large-optimized.svg'), 
                        Image.asset('assets/icons/logo_large.png', scale: 1.0),
                        const SizedBox(height: 50),

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
                        // TODO (mtourne): add forgot password

                        const SizedBox(height: 25),

                        // log in button
                        MyButton(
                            text: "Log in",
                            onTap: signUserIn,
                        ),

                        // or continue with google / apple sign in.

                        // not a member? sign up
                    
                    ],
                ), 
            ),
        ),
        );
    }
} 