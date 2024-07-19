import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokedex/Application/Views/Authentication/authentication_viewmodel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

@RoutePage()
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
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

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
            return LayoutBuilder(
              builder: (context, constraints) {
                return Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                          maxWidth: kIsWeb ? 400 : constraints.maxWidth),
                      child: IntrinsicHeight(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'lib/assets/images/logo.png',
                              height: kIsWeb ? 100 : null,
                            ),
                            const SizedBox(
                              height: 48,
                            ),
                            Text(
                              viewModel.isLogin
                                  ? "Welcome back Trainer!"
                                  : "Welcome Trainer!",
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
                                  color: Colors.grey.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(16)),
                              child: SingleChildScrollView(
                                child: Form(
                                  key: _form,
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 16),
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          controller: viewModel.emailController,
                                          decoration: const InputDecoration(
                                            labelText: "Email",
                                            labelStyle:
                                                TextStyle(color: Colors.white),
                                          ),
                                          autocorrect: false,
                                          textCapitalization:
                                              TextCapitalization.none,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          validator: (value) =>
                                              viewModel.validateEmail(value),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        TextFormField(
                                          controller:
                                              viewModel.passwordController,
                                          decoration: const InputDecoration(
                                            labelText: "Password",
                                            labelStyle:
                                                TextStyle(color: Colors.white),
                                          ),
                                          obscureText: true,
                                          autocorrect: false,
                                          enableSuggestions: false,
                                          textCapitalization:
                                              TextCapitalization.none,
                                          validator: (value) =>
                                              viewModel.validatePassword(value),
                                        ),
                                        if (!viewModel.isLogin)
                                          TextFormField(
                                            controller: viewModel
                                                .confirmPasswordController,
                                            decoration: const InputDecoration(
                                              labelText: "Confirm password",
                                              labelStyle: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            obscureText: true,
                                            autocorrect: false,
                                            enableSuggestions: false,
                                            textCapitalization:
                                                TextCapitalization.none,
                                            validator: (value) => viewModel
                                                .validateConfirmPassword(value),
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
                            if (isAuthenticating)
                              const CircularProgressIndicator(),
                            if (!isAuthenticating)
                              ElevatedButton(
                                onPressed: () {
                                  viewModel.save(_form, context);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Text(
                                    viewModel.isLogin ? "Login" : "Sign up",
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
                                  _form.currentState!.reset();
                                  setState(() {
                                    viewModel.toggleLogin();
                                  });
                                },
                                child: Text(
                                  viewModel.isLogin
                                      ? "Register an account"
                                      : "Sign in",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            Spacer()
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
