import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/ui/widgets/login_widgets.dart';
import 'package:movies_app/services/authentication.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginView extends ConsumerStatefulWidget {

  const LoginView({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => LoginState();

}

class LoginState extends ConsumerState<LoginView> {

  GlobalKey<FormState> inFormKey = GlobalKey<FormState>();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
        child: Form(
          key: inFormKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SingleChildScrollView(
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
                buildEmailTextField(emailCtrl, true),
                SizedBox(height: size.height / 20),
                buildPasswordTextField(passwordCtrl, 'Your password...'),
                SizedBox(height: size.height / 100),
                TextButton(
                  child: Text(
                    'Forgot password?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  onPressed: () => Navigator.of(context).popAndPushNamed(
                      '/reset_password',
                  ),
                ),
                SizedBox(height: size.height / 20),
                ElevatedButton(
                  onPressed: () async {
                    if (inFormKey.currentState!.validate()) {
                      bool success = await signin(context, emailCtrl.text, passwordCtrl.text);
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
                    'Sign in',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(height: size.height / 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Not registered yet?',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.popAndPushNamed(
                        context,
                        '/signup',
                      ),
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height / 50),
                Text(
                  'Or',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(height: size.height / 50),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    fixedSize: Size(size.width / 2, size.height / 15),
                    elevation: 0,
                  ),
                  onPressed: () async {
                    bool success = await signinWithGoogle(context);
                    if (success) {
                      Navigator.of(context).pushNamed('/main');
                    }
                    },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.google,
                        color: Theme.of(context).colorScheme.secondary,
                        size: 20,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'Sign in with Google',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ],
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