import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/ui/widgets/login_widgets.dart';
import 'package:movies_app/services/authentication.dart';

class SignupView extends ConsumerStatefulWidget {

  const SignupView({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => SignupState();

}

class SignupState extends ConsumerState<SignupView> {

  GlobalKey<FormState> upFormKey = GlobalKey<FormState>();
  final userCtrl = TextEditingController();
  final upEmailCtrl = TextEditingController();
  final password1Ctrl = TextEditingController();
  final password2Ctrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
        padding: EdgeInsets.symmetric(horizontal: size.width / 10),
        child: Form(
          key: upFormKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: size.height / 6),
                const Text(
                  'Movies App',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: size.height / 10),
                TextFormField(
                  controller: userCtrl,
                  decoration: InputDecoration(
                    hintText: 'Your username...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    suffixIcon: const Icon(Icons.drive_file_rename_outline),
                  ),
                  validator: (value) => value == null
                  ? 'Username is required' : null,
                ),
                SizedBox(height: size.height / 30),
                buildEmailTextField(upEmailCtrl, false),
                SizedBox(height: size.height / 30),
                buildPasswordTextField(password1Ctrl, 'Your password...'),
                SizedBox(height: size.height / 30),
                buildPasswordTextField(password2Ctrl, 'Confirm your password...'),
                SizedBox(height: size.height / 20),
                ElevatedButton(
                  onPressed: () async {
                    if (upFormKey.currentState!.validate()) {
                      final success = await signup(
                          context, upEmailCtrl.text, password1Ctrl.text,
                      );
                      if (success) {
                        Navigator.of(context).pushNamed('/main');
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    fixedSize: Size(size.width / 2, size.height / 15),
                  ),
                  child: Text(
                    'Sign up',
                    style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
                SizedBox(height: size.height / 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Already have an account?',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.popAndPushNamed(
                          context,
                          '/login',
                      ),
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}