
import 'package:firebase_example/data/api/auth_api.dart';
import 'package:firebase_example/pages/forgot_password_page.dart';
import 'package:firebase_example/pages/home_page.dart';
import 'package:firebase_example/utils/utils.dart';
import 'package:firebase_example/widgets/app_button.dart';
import 'package:firebase_example/widgets/app_password_field.dart';
import 'package:firebase_example/widgets/app_text_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _emailEditingController = TextEditingController();
  final _passwordEditingController = TextEditingController();

  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  String _emailError = "";
  String _passwordError = "";

  bool _isLoginInProgress = false;
  bool _showPassword = false;

  final _authApi = AuthApi();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(30),
              child: Column(
                children: [
                  // app icon image
                  Image.asset(
                    "assets/images/app_icon.jpg",
                    width: 150,
                    height: 150,
                  ),
                  const SizedBox(height: 30,),
                  const Text(
                    "Welcome back!",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.black
                    ),
                  ),
                  const SizedBox(height: 10,),
                  const Text(
                    "Login to your account",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black45
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
                  const SizedBox(height: 15,),
                  // forgot password
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        // on forgot password pressed
                        // navigate to ForgotPasswordPage
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordPage(),));
                      },
                      child: const Text(
                        "Forgot Password",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30,),
                  // login button
                  AppButton(
                    onPressed: () {
                      // on login pressed
                      // validate data
                      // send login request
                      if (_validate(context)) {
                        _login(context);
                      }
                    },
                    label: "Login",
                    width: double.maxFinite,
                    isInProgress: _isLoginInProgress,
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
  // return true if data is valid
  // return false if data is invalid
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

  // LOGIN
  // navigate to HomePage on login success
  // show error on login error
  void _login(BuildContext context) async {
    setState(() {
      _isLoginInProgress = true;
    });
    try {
      await _authApi.login(_emailEditingController.text, _passwordEditingController.text);
      setState(() {
        _isLoginInProgress = false;
      });
      // login success
      // show success message on toast
      // navigate to HomePage
      Utils.showToast("Logged in successfully");
      if (context.mounted) {
        Navigator.pushReplacement(context,
            PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => HomePage(),));
      }
    } catch (e) {
      setState(() {
        _isLoginInProgress = false;
      });
      // login error
      // show error on snack bar
      if (context.mounted) {
        Utils.showErrorSnackBar(context, e.toString());
      }
    }
  }
}
