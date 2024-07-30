import 'package:flutter/material.dart';
import 'package:lcpl_academy/provider/loading_provider.dart';
import 'package:lcpl_academy/provider/password_visibility_provider.dart';
import 'package:lcpl_academy/reusablewidgets/reusable_button.dart';
import 'package:lcpl_academy/reusablewidgets/reusable_text_field.dart';
import 'package:lcpl_academy/screens/authscreens/signup_screen.dart';
import 'package:lcpl_academy/theme/theme.dart';
import 'package:lcpl_academy/utils/constants.dart';
import 'package:lcpl_academy/utils/utils.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: formKey,
          child: Stack(children: [
            const Padding(
              padding: EdgeInsets.only(top: 100),
              child: Image(
                image: AssetImage(Constants.logo),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Expanded(flex: 2, child: SizedBox()),
                ReusableTextField(
                  hintText: 'Email',
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  focusNode: emailFocusNode,
                  prefix: const Icon(Icons.alternate_email),
                  validator: Utils.emailValidator,
                  onFieldSubmitted: (value) {
                    Utils.changeFocus(
                        currentFocus: emailFocusNode,
                        nextFocus: passwordFocusNode,
                        context: context);
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                Consumer<PasswordVisibilityProvider>(
                  builder: (BuildContext context,
                      PasswordVisibilityProvider value, Widget? child) {
                    return ReusableTextField(
                      focusNode: passwordFocusNode,
                      hintText: 'Password',
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: value.visibility,
                      prefix: const Icon(Icons.lock),
                      validator: Utils.passwordValidator,
                      suffix: GestureDetector(
                        onTap: () {
                          value.setVisibility();
                        },
                        child: Icon(value.visibility
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                Consumer<AuthProvider>(
                  builder: (BuildContext context, AuthProvider value,
                      Widget? child) {
                    return ReusableButton(
                        title: 'Login',
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            value.signInWithEmail(emailController.text,
                                passwordController.text, context);
                          }
                        },
                        loading: value.loading);
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Didn\'t have an account?',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: AppTheme.darkGrey,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignupScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Signup',
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: AppTheme.blueColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                  ],
                ),
                const Expanded(flex: 1, child: SizedBox()),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
