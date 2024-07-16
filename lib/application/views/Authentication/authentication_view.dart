import 'package:flutter/material.dart';
import 'package:pokedex/Application/Views/Authentication/authentication_viewmodel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationView extends StatefulWidget {
  const AuthenticationView({super.key});

  @override
  State<AuthenticationView> createState() {
    return _AuthenticationViewState();
  }
}

class _AuthenticationViewState extends State<AuthenticationView> {
  final viewModel = AuthenticationViewModel();
  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
      ),
      backgroundColor: Colors.red,
      body: BlocBuilder<AuthenticationViewModel, bool>(
          bloc: viewModel,
          builder: (ctx, isAuthenticating) {
            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('lib/assets/images/logo.png'),
                    const SizedBox(
                      height: 48,
                    ),
                    Text(
                      viewModel.isLogin
                          ? "Bentornato Allenatore!"
                          : "Benvenuto Allenatore!",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(16)),
                      child: SingleChildScrollView(
                        child: Form(
                          key: _form,
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            child: Column(
                              children: [
                                if (!viewModel.isLogin)
                                  TextFormField(
                                    decoration: const InputDecoration(
                                      labelText: "Nome",
                                      labelStyle:
                                          TextStyle(color: Colors.white),
                                    ),
                                    validator: (value) =>
                                        viewModel.validateName(value),
                                    onSaved: (newValue) => viewModel.isLogin
                                        ? null
                                        : viewModel.setName(newValue!),
                                  ),
                                if (!viewModel.isLogin)
                                  const SizedBox(
                                    height: 8,
                                  ),
                                TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: "Email",
                                    labelStyle: TextStyle(color: Colors.white),
                                  ),
                                  autocorrect: false,
                                  textCapitalization: TextCapitalization.none,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) =>
                                      viewModel.validateEmail(value),
                                  onSaved: (newValue) =>
                                      viewModel.setEmail(newValue!),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: "Password",
                                    labelStyle: TextStyle(color: Colors.white),
                                  ),
                                  obscureText: true,
                                  autocorrect: false,
                                  enableSuggestions: false,
                                  textCapitalization: TextCapitalization.none,
                                  validator: (value) =>
                                      viewModel.validatePassword(value),
                                  onSaved: (newValue) =>
                                      viewModel.setPassword(newValue!),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    if (isAuthenticating) const CircularProgressIndicator(),
                    if (!isAuthenticating)
                      ElevatedButton(
                        onPressed: () {
                          viewModel.save(_form, context);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            viewModel.isLogin ? "Login" : "Registrati",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (!isAuthenticating)
                      TextButton(
                        onPressed: () {
                          setState(() {
                            viewModel.toggleLogin();
                          });
                        },
                        child: Text(
                          viewModel.isLogin
                              ? "Registra un account"
                              : "Esegui l'accesso",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                      )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
