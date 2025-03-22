import 'package:flutter/material.dart';
import 'package:twitter_app/components/my_button.dart';
import 'package:twitter_app/components/my_loading_circle.dart';
import 'package:twitter_app/components/my_text_field.dart';
import 'package:twitter_app/services/auth/auth_services.dart';
import 'package:twitter_app/services/database/database_service.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final auth = AuthServices();
  final _db = DatabaseService();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwController = TextEditingController();
  final TextEditingController confirmPwController = TextEditingController();

  void register() async {
    if (pwController.text == confirmPwController.text) {
      showLoadingCircle(context);

      try {
        await auth.registerEmailPassword(
          emailController.text,
          pwController.text,
        );
        if (mounted) hideLoadingCircle(context);

        //store profile in database
        await _db.saveUserInfoInFirebase(
          name: nameController.text,
          email: emailController.text,
        );
      } catch (e) {
        if (mounted) hideLoadingCircle(context);

        if (mounted) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(title: Text(e.toString())),
          );
        }
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(title: Text("Passeords do no match")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //icon
                Icon(
                  Icons.lock_open_rounded,
                  size: 72,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 50),
                //text
                Text(
                  "Lets create an account for you..",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 25),

                MyTextField(
                  controller: nameController,
                  hinttext: "Name",
                  obscureText: false,
                ),

                const SizedBox(height: 10),
                MyTextField(
                  controller: emailController,
                  hinttext: "Email",
                  obscureText: false,
                ),
                //
                SizedBox(height: 10),
                MyTextField(
                  controller: pwController,
                  hinttext: "Password",
                  obscureText: true,
                ),
                SizedBox(height: 10),

                MyTextField(
                  controller: confirmPwController,
                  hinttext: "Confirm Password",
                  obscureText: true,
                ),
                SizedBox(height: 25),

                //
                MyButton(onTap: register, text: 'Register'),

                SizedBox(height: 25),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already a member?",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "Login Now",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
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
