
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {

  //SHOW TOAST
  static void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  // SHOW ERROR SNACK BAR
  static void showErrorSnackBar(BuildContext context, String message) {
    SnackBar snackBar = SnackBar(
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.error,
            color: Colors.white,
            size: 24,
          ),
          const SizedBox(width: 20,),
          Flexible(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
          )
        ],
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      padding: const EdgeInsets.all(10),
      behavior: SnackBarBehavior.floating,
      elevation: 5,
    );
    // show snack bar
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // SHOW MESSAGE DIALOG
  static void showMessageDialog(BuildContext context, String message) {
    Dialog dialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
            ),
            const SizedBox(height: 15,),
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {
                  // on OK button pressed
                  // pop the dialog
                  Navigator.pop(context);
                },
                child: const Text(
                  "Ok",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    // show dialog
    showDialog(context: context, builder: (context) => dialog, barrierDismissible: false);
  }
}