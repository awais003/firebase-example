

import 'package:firebase_example/data/api/auth_api.dart';
import 'package:firebase_example/utils/utils.dart';
import 'package:flutter/material.dart';

import 'app_button.dart';
import 'app_text_field.dart';

class OtpView extends StatefulWidget {
  const OtpView({
    super.key,
    required this.phoneNumber,
    required this.verificationId,
    required this.onLoggedIn,
  });

  final String phoneNumber;
  final String verificationId;
  final Function() onLoggedIn;

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {

  late String _verificationId;

  final _otpCodeEditingController = TextEditingController();

  final _otpCodeFocusNode = FocusNode();

  String _otpCodeError = "";

  bool _isOtpCodeVerifyInProgress = false;
  bool _isResendOtpCodeInProgress = false;

  final _authApi = AuthApi();

  @override
  void initState() {
    super.initState();

    setState(() {
      _verificationId = widget.verificationId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        )
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: 30,
          right: 30,
          top: 30,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Code Verification",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 10,),
            Text(
              "We have sent you the OTP code on ${widget.phoneNumber}",
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.black87,
                fontSize: 13,
              ),
            ),
            AppTextField(
              controller: _otpCodeEditingController,
              label: "",
              hint: "Enter OTP code",
              focusNode: _otpCodeFocusNode,
              error: _otpCodeError,
              icon: Icons.phone_android,
              textInputType: TextInputType.number,
            ),
            const SizedBox(height: 20,),
            // confirm button
            AppButton(
              onPressed: () {
                // on confirm button click event
                if (_validate(context)) {
                  _verifyOtpCode(context);
                }
              },
              label: "Confirm",
              backgroundColor: Colors.deepPurple,
              width: double.maxFinite,
              isInProgress: _isOtpCodeVerifyInProgress,
            ),
            const SizedBox(height: 20,),
            _isResendOtpCodeInProgress? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                strokeWidth: 2,
              ),
            ) : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Did not receive the code? ",
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
                // resend text button
                InkWell(
                  onTap: () {
                    // on resend text button click event
                    _resendOtpCode(context);
                  },
                  child: const Text(
                    "Resend",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 15
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30,),
          ],
        ),
      ),
    );
  }

  // VALIDATE
  // return true/false based on validate data
  bool _validate(BuildContext context) {
    setState(() {
      _otpCodeError = "";
    });

    bool isValid = true;

    if (_otpCodeEditingController.text.isEmpty) {
      isValid = false;
      setState(() {
        _otpCodeError = "Required";
      });
    }

    return isValid;
  }

  // VERIFY OTP CODE
  void _verifyOtpCode(BuildContext context) async {
    setState(() {
      _isOtpCodeVerifyInProgress = true;
    });
    try {
      await _authApi.verifyOtp(_verificationId, _otpCodeEditingController.text);
      // on success response
      setState(() {
        _isOtpCodeVerifyInProgress = false;
      });
      widget.onLoggedIn();
    } catch (e) {
      // on error response
      setState(() {
        _isOtpCodeVerifyInProgress = false;
      });
      Utils.showToast(e.toString());
    }
  }

  // RESEND OTP CODE
  void _resendOtpCode(BuildContext context) {
    setState(() {
      _isResendOtpCodeInProgress = true;
    });
    _authApi.verifyPhoneNumber(widget.phoneNumber, onCodeSent: (verificationId) {
      // on success response
      setState(() {
        _isResendOtpCodeInProgress = false;
      });
      Utils.showToast("OTP resent successfully");
    }, onError: (error) {
      // on error response
      setState(() {
        _isResendOtpCodeInProgress = false;
      });
      Utils.showToast(error.toString());
    },);
  }

}
