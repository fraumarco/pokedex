import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/application/models/logged_user.dart';
import 'package:pokedex/application/navigation/app_router.dart';

class AuthenticationViewModel extends Cubit<bool> {
  AuthenticationViewModel() : super(false);

  bool isLogin = true;
  bool isAuthenticating = false;
  String _enteredName = "";
  String _enteredEmail = "";
  String _enteredPassword = "";

  void toggleLogin() {
    isLogin = !isLogin;
  }

  String? validateEmail(String? email) {
    if (email == null || email.trim().isEmpty || !email.contains("@")) {
      return "Mail non valida. Inseriscine una esistente.";
    }

    return null;
  }

  String? validatePassword(String? password) {
    if (password == null || password.length < 6) {
      return "La password deve contenere almeno 6 caratteri";
    }

    return null;
  }

  String? validateName(String? name) {
    if (name == null || name.trim().isEmpty) {
      return "Il nome non può essere vuoto";
    }

    return null;
  }

  void setName(String name) {
    _enteredName = name;
  }

  void setEmail(String email) {
    _enteredEmail = email;
  }

  void setPassword(String password) {
    _enteredPassword = password;
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
            email: _enteredEmail, password: _enteredPassword);

        if (context.mounted) {
          context.router.push(const PokemonListRoute());
        }
      } else {
        final userCredentials = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _enteredEmail, password: _enteredPassword);

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredentials.user!.uid)
            .set({"name": _enteredName});

        if (context.mounted) {
          context.router.push(const PokemonListRoute());
        }
      }
    } on FirebaseAuthException catch (error) {
      emit(false); //Done authenticating

      String errorMessage = "";

      if (error.code == "invalid-credential") {
        errorMessage = "Mail o password non valide.";
      } else if (error.code == "user-disabled") {
        errorMessage = "Utente disabilitato.";
      } else if (error.code == "user-not-found") {
        errorMessage = "Questo utente non esiste.";
      } else if (error.code == "email-already-in-use") {
        errorMessage = "Questo utente è già registrato.";
      } else {
        errorMessage = "Oops, qualcosa è andato storto";
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
