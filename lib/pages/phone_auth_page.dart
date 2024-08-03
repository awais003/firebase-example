

import 'package:firebase_example/data/api/auth_api.dart';
import 'package:firebase_example/pages/home_page.dart';
import 'package:firebase_example/utils/utils.dart';
import 'package:firebase_example/widgets/app_button.dart';
import 'package:firebase_example/widgets/app_text_field.dart';
import 'package:firebase_example/widgets/otp_view.dart';
import 'package:flutter/material.dart';

class PhoneAuthPage extends StatefulWidget {
  const PhoneAuthPage({super.key});

  @override
  State<PhoneAuthPage> createState() => _PhoneAuthPageState();
}

class _PhoneAuthPageState extends State<PhoneAuthPage> {

  final _phoneNumberEditingController = TextEditingController();

  final _phoneNumberFocusNode = FocusNode();

  String _phoneNumberError = "";

  bool _isVerifyPhoneNumberInProgress = false;

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
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 30,),
                  const Text(
                    "Verify Phone Number",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 30,
                    ),
                  ),
                  const SizedBox(height: 10,),
                  const Text(
                    "We will sent you a code to verify your phone number",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.black87,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 30,),
                  AppTextField(
                    controller: _phoneNumberEditingController,
                    label: "Mobile Number",
                    hint: "Enter mobile number",
                    focusNode: _phoneNumberFocusNode,
                    error: _phoneNumberError,
                    icon: Icons.phone_android,
                    textInputType: TextInputType.phone,
                  ),
                  const SizedBox(height: 20,),
                  // continue button
                  AppButton(
                      onPressed: () {
                        // on continue button pressed
                        if (_validate(context)) {
                          _verifyPhoneNumber(context);
                        }
                      },
                      label: "Continue",
                    backgroundColor: Colors.deepPurple,
                    width: double.maxFinite,
                    isInProgress: _isVerifyPhoneNumberInProgress,
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
      _phoneNumberError = "";
    });

    bool isValid = true;

    if (_phoneNumberEditingController.text.isEmpty) {
      isValid = false;
      setState(() {
        _phoneNumberError = "Required";
      });
    }

    return isValid;
  }

  // VERIFY PHONE NUMBER
  void _verifyPhoneNumber(BuildContext context) async  {
    setState(() {
      _isVerifyPhoneNumberInProgress = true;
    });
    _authApi.verifyPhoneNumber(_phoneNumberEditingController.text, onCodeSent: (verificationId) {
      // on success response
      // show otp code view to input otp code
      setState(() {
        _isVerifyPhoneNumberInProgress = false;
      });
      Utils.showToast("OTP code is sent to your number");
      _showBottomSheet(context, verificationId, _phoneNumberEditingController.text);
    }, onError: (error) {
      // on error response
      setState(() {
        _isVerifyPhoneNumberInProgress = false;
      });
      Utils.showErrorSnackBar(context, error.toString());
    },);
  }

  // SHOW BOTTOM SHEET
  void _showBottomSheet(BuildContext context, String verificationId, String phoneNumber) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => OtpView(
        phoneNumber: phoneNumber,
        verificationId: verificationId,
        onLoggedIn: () {
          // on logged in
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(),));
        },
      ),
    );
  }
}
