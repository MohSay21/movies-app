import 'package:flutter/material.dart';
import 'package:movies_app/services/authentication.dart';
import 'package:movies_app/ui/widgets/login_widgets.dart';

class ResetPasswordView extends StatefulWidget {

  const ResetPasswordView({Key? key}) : super(key: key);

  @override
  State createState() => ResetPasswordState();

}

class ResetPasswordState extends State<ResetPasswordView> {

  GlobalKey<FormState> resetFormKey = GlobalKey<FormState>();
  final resetEmailCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: size.width / 10),
            child: Form(
              key: resetFormKey,
              child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: size.height / 4),
                const Text(
                  'Movies App',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: size.height / 8),
                buildEmailTextField(resetEmailCtrl, true),
                SizedBox(height: size.height / 8),
                ElevatedButton(
                  onPressed: () {
                    if (resetFormKey.currentState!.validate()) {
                      resetPassword(context, resetEmailCtrl.text);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    fixedSize: Size(size.width / 2, size.height / 15),
                  ),
                 child: const Text(
                   'Reset password',
                   style: TextStyle(
                     fontSize: 18,
                     fontWeight: FontWeight.w700,
                   ),
                 ),
                ),
              ],
            ),
          ),
      ),
        ),
    );
  }

}