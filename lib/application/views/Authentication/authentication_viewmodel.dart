import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/application/navigation/app_router.dart';

class AuthenticationViewModel extends Cubit<bool> {
  AuthenticationViewModel() : super(false);

  bool isLogin = true;
  bool isAuthenticating = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  void toggleLogin() {
    isLogin = !isLogin;
  }

  String? validateEmail(String? email) {
    if (email == null || email.trim().isEmpty || !email.contains("@")) {
      return "Invalid mail. Please insert a valid one.";
    }

    return null;
  }

  String? validatePassword(String? password) {
    if (password == null || password.length < 6) {
      return "Password must be at least 6 characters long";
    }

    return null;
  }

  String? validateConfirmPassword(String? password) {
    if (passwordController.text != confirmPasswordController.text) {
      return "Passwords must match with eachother";
    }

    return null;
  }

  void save(GlobalKey<FormState> form, BuildContext context) async {
    final isValid = form.currentState!.validate();

    if (!isValid) {
      return;
    }

    form.currentState!.save();

    try {
      emit(true); //Is authenticating

      if (isLogin) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);

        if (context.mounted) {
          context.router.push(const TabsRoute());
        }
      } else {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);

        if (context.mounted) {
          context.router.push(const TabsRoute());
        }
      }
    } on FirebaseAuthException catch (error) {
      emit(false); //Done authenticating

      String errorMessage = "";

      if (error.code == "invalid-credential") {
        errorMessage = "Inavalid mail or password.";
      } else if (error.code == "user-disabled") {
        errorMessage = "User disabled.";
      } else if (error.code == "user-not-found") {
        errorMessage = "This user does not exists.";
      } else if (error.code == "email-already-in-use") {
        errorMessage = "This user is already registered.";
      } else {
        errorMessage = "Oops, something went wrong";
      }

      if (context.mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
          ),
        );
      }
    }
  }
}
