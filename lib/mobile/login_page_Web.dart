import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';

import '../Components.dart';
import '../viewModal.dart';

class LoginPageWeb extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModal = ref.watch(userLogin);
    TextEditingController emailController = useTextEditingController();
    TextEditingController passwordController = useTextEditingController();
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: deviceWidth,
              child: Row(
                mainAxisAlignment: .spaceAround,
                children: [
                  Image.asset(
                    'assets/login_image.png',
                    width: deviceWidth / 2.5,
                    height: deviceHeight,
                    fit: BoxFit.fitHeight,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: .center,
                    children: [
                      SizedBox(height: 100.0),
                      Image.asset(
                        'assets/logo.png',
                        width: deviceWidth / 6,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(height: 40.0),
                      textField(
                        width: 270.0,
                        text: 'E-Mail',
                        controller: emailController,
                        icon: Icons.email,
                        keyBoardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 40.0),
                      Text(
                        'Enter your passWord',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      SizedBox(height: 10.0),
                      SizedBox(
                        width: 270.0,
                        child: TextFormField(
                          textAlign: .center,
                          controller: passwordController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 3.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.blue,
                                width: 3.0,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 3.0,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 3.0,
                              ),
                            ),
                            prefixIcon: IconButton(
                              onPressed: () {
                                viewModal.obsureText();
                              },
                              icon: Icon(
                                viewModal.isObscure
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                            ),
                            label: Text(
                              'passWord',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                          obscureText: viewModal.isObscure,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: .center,
                        children: [
                          MaterialButton(
                            onPressed: () async {
                              await viewModal.signInUsingEmailAndPassword(
                                Email: emailController.text,
                                Password: passwordController.text,
                                context: context,
                              );
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(10),
                            ),
                            child: Text(
                              'Sign-In',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24.0,
                              ),
                            ),
                            color: Colors.black,
                            minWidth: 50.0,
                            splashColor: Colors.blue,
                          ),
                          SizedBox(width: 20.0),
                          Text(
                            'Or',
                            style: GoogleFonts.aBeeZee(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: .bold,
                            ),
                          ),
                          SizedBox(width: 20.0),
                          MaterialButton(
                            onPressed: () async {
                              await viewModal.logInUsingEmailAndPassword(
                                context: context,
                                Email: emailController.text,
                                Password: passwordController.text,
                              );
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(10.0),
                            ),
                            child: Text(
                              'Log-In',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24.0,
                              ),
                            ),
                            color: Colors.black,
                            minWidth: 50.0,
                            splashColor: Colors.blue,
                          ),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      Column(
                        children: [
                          SignInButton(
                            buttonType: ButtonType.google,
                            btnColor: Colors.white,

                            onPressed: () async {
                              if (kIsWeb) {
                                await viewModal.SignInWithGoogleWeb(context);
                              } else {
                                await viewModal.SignInGoogleMobile(context);
                              }
                            },
                          ),
                          SizedBox(height: 20),
                          SignInButton(
                            buttonType: ButtonType.apple,
                            onPressed: () async {
                              await viewModal.loginWithApple();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
