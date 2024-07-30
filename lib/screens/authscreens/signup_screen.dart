import 'package:flutter/material.dart';
import 'package:lcpl_academy/provider/loading_provider.dart';
import 'package:lcpl_academy/provider/password_visibility_provider.dart';
import 'package:lcpl_academy/reusablewidgets/reusable_button.dart';
import 'package:lcpl_academy/reusablewidgets/reusable_text_field.dart';
import 'package:lcpl_academy/screens/authscreens/login_screen.dart';
import 'package:lcpl_academy/theme/theme.dart';
import 'package:lcpl_academy/utils/constants.dart';
import 'package:lcpl_academy/utils/utils.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Image(
                image: AssetImage(Constants.logo),
              ),
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
              const SizedBox(height: 30),
              Consumer<AuthProvider>(
                builder:
                    (BuildContext context, AuthProvider value, Widget? child) {
                  return ReusableButton(
                      title: 'Signup',
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          value.signUpWithEmail(
                              emailController.text, passwordController.text,context);
                        }
                      },
                      loading: value.loading);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already a user?',
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: AppTheme.darkGrey,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Login',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: AppTheme.blueColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
