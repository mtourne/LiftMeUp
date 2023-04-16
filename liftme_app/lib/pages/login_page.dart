import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../components/my_textfield.dart';
import '../components/my_button.dart';


class LoginPage extends StatelessWidget {
    LoginPage({super.key});

    // text editing controllers
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();

    // TODO (mtourne): sign user in
    void signUserIn() {}

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