

import 'package:firebase_example/data/api/auth_api.dart';
import 'package:firebase_example/utils/utils.dart';
import 'package:flutter/material.dart';

import '../widgets/app_button.dart';
import '../widgets/app_password_field.dart';
import '../widgets/app_text_field.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  final _emailEditingController = TextEditingController();
  final _passwordEditingController = TextEditingController();

  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  String _emailError = "";
  String _passwordError = "";

  bool _showPassword = false;
  bool _isSignupInProgress = false;

  final _authApi = AuthApi();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            // on back button pressed
            // navigate to pop back
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_sharp,
            color: Colors.black,
            size: 24,
          ),
        ),
      ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/app_icon.jpg",
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 30,),
                  const Text(
                    "Signup",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 30,
                    ),
                  ),
                  const SizedBox(height: 10,),
                  const Text(
                    "Create new account",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 30,),
                  // email text field
                  AppTextField(
                    controller: _emailEditingController,
                    label: "Email",
                    hint: "Email",
                    focusNode: _emailFocusNode,
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.emailAddress,
                    icon: Icons.email,
                    error: _emailError,
                  ),
                  const SizedBox(height: 20,),
                  AppPasswordField(
                    controller: _passwordEditingController,
                    label: "Password",
                    hint: "Password",
                    focusNode: _passwordFocusNode,
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    icon: Icons.lock,
                    error: _passwordError,
                    showPassword: _showPassword,
                    onShowPassword: () {
                      // toggle show password
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    },
                  ),
                  const SizedBox(height: 20,),
                  AppButton(
                    onPressed: () {
                      // on signup pressed
                      if (_validate(context)) {
                        _signup(context);
                      }
                    },
                    label: "Signup",
                    width: double.maxFinite,
                    isInProgress: _isSignupInProgress,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // VALIDATE
  // return true/false based on data validation
  bool _validate(BuildContext context) {
    setState(() {
      _emailError = "";
      _passwordError = "";
    });

    bool isValid = true;

    if (_emailEditingController.text.isEmpty) {
      isValid = false;
      setState(() {
        _emailError = "Required";
      });
    }

    if (_passwordEditingController.text.isEmpty) {
      isValid = false;
      setState(() {
        _passwordError = "Required";
      });
    }

    return isValid;
  }

  // RESET
  void _reset() {
    setState(() {
      _emailEditingController.text = "";
      _passwordEditingController.text = "";
    });
  }

  // SIGNUP
  void _signup(BuildContext context) async {
    setState(() {
      _isSignupInProgress = true;
    });
    try {
      await _authApi.signup(_emailEditingController.text, _passwordEditingController.text);
      // success response
      setState(() {
        _isSignupInProgress = false;
      });
      _reset();
      Utils.showToast("Account created successfully");
    } catch (e) {
      // error response
      setState(() {
        _isSignupInProgress = false;
      });
      if (context.mounted) {
        Utils.showErrorSnackBar(context, e.toString());
      }
    }
  }
}
