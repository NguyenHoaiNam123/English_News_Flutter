import 'package:english_app/pages/login_page.dart';
import 'package:english_app/pages/register_page.dart';
import 'package:english_app/utils/cubit/auth/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthNavigator extends StatelessWidget {
  const AuthNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      return Navigator(
        pages: [
          // Show login
          if (state is AuthLogin) const MaterialPage(child: LoginPage()),

          // Allow push animation
          if (state is AuthSignUp) const MaterialPage(child: RegisterPage()),
        ],
        onPopPage: (route, result) => route.didPop(result),
      );
    });
  }
}
