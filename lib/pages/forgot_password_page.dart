

import 'package:firebase_example/data/api/auth_api.dart';
import 'package:firebase_example/utils/utils.dart';
import 'package:flutter/material.dart';

import '../widgets/app_button.dart';
import '../widgets/app_text_field.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  final _emailEditingController = TextEditingController();

  final _emailFocusNode = FocusNode();

  String _emailError = "";

  bool _isResetPasswordInProgress = false;

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Forgot Password",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 30
                    ),
                  ),
                  const SizedBox(height: 10,),
                  const Text(
                    "We will send you password confirmation link on your registered email address",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black54,
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
                  const SizedBox(height: 30,),
                  // reset password button
                  AppButton(
                    onPressed: () {
                      // on reset button pressed
                      // validate data then send reset password request
                      if (_validate(context)) {
                        _resetPassword(context);
                      }
                    },
                    label: "Reset",
                    width: double.maxFinite,
                    isInProgress: _isResetPasswordInProgress,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // VALIDATE DATA
  // return true/false based on data validation
  bool _validate(BuildContext context) {
    setState(() {
      _emailError = "";
    });

    bool isValid = true;

    if (_emailEditingController.text.isEmpty) {
      isValid = false;
      setState(() {
        _emailError = "Required";
      });
    }

    return isValid;
  }

  // RESET PASSWORD
  // send reset password request and handle response
  void _resetPassword(BuildContext context) async {
    setState(() {
      _isResetPasswordInProgress = true;
    });
    try {
      await _authApi.resetPassword(_emailEditingController.text);
      // success response
      // show password reset success message on dialog
      setState(() {
        _isResetPasswordInProgress = false;
      });
      if (context.mounted) {
        Utils.showMessageDialog(context, "We sent you password reset link on your registered email address, please check your email for further instructions");
      }
    } catch (e) {
      // error response
      setState(() {
        _isResetPasswordInProgress = false;
      });
      // show error on snack bar
      if (context.mounted) {
        Utils.showErrorSnackBar(context, e.toString());
      }
    }
  }
}