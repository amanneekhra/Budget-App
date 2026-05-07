import 'package:budgetapp/Components.dart';
import 'package:budgetapp/viewModal.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';

class LoginPageMob extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModal = ref.watch(userLogin);
    TextEditingController emailController = useTextEditingController();
    TextEditingController passwordController = useTextEditingController();

    final deviceWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: deviceWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: .center,
                children: [
                  SizedBox(height: 100),
                  Image.asset(
                    'assets/logo.png',
                    width: 210,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: 40),
                  textField(
                    text: 'E-Mail',
                    controller: emailController,
                    icon: Icons.email,
                    keyBoardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 40),
                  Text('Enter your passWord', style: TextStyle(fontSize: 20)),
                  SizedBox(height: 10),
                  SizedBox(
                    width: 270,
                    child: TextFormField(
                      textAlign: .center,
                      controller: passwordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.black, width: 3),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.blue, width: 3),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.red, width: 3),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.red, width: 3),
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
                  SizedBox(height: 20),
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
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                        color: Colors.black,
                        minWidth: 50,
                        splashColor: Colors.blue,
                      ),
                      SizedBox(width: 20),
                      Text(
                        'Or',
                        style: GoogleFonts.aBeeZee(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: .bold,
                        ),
                      ),
                      SizedBox(width: 20),
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
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                        color: Colors.black,
                        minWidth: 50,
                        splashColor: Colors.blue,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
