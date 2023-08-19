import 'package:english_app/pages/dashboard_page.dart';
import 'package:english_app/utils/auth/auth_navigator.dart';
import 'package:english_app/utils/cubit/auth/auth_cubit.dart';
import 'package:english_app/utils/cubit/get_data/get_data_cubit.dart';
import 'package:english_app/utils/cubit/get_new/get_new_cubit.dart';
import 'package:english_app/utils/cubit/session/session_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppNavigator extends StatelessWidget {
  const AppNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.blueGrey[900],
          appBarTheme: AppBarTheme(backgroundColor: Colors.blueGrey[900])),
      home: BlocProvider(
        create: (context) => GetNewCubit(),
        child:
            BlocBuilder<SessionCubit, SessionState>(builder: (context, state) {
          return Navigator(
            pages: [
              // Show loading screen
              if (state is Authenticating) ...[
                MaterialPage(
                  child: BlocProvider(
                    create: (context) =>
                        AuthCubit(sessionCubit: context.read<SessionCubit>()),
                    child: const AuthNavigator(),
                  ),
                )
              ] else ...[
                MaterialPage(
                    child: BlocProvider(
                  create: (context) =>
                      GetDataCubit(sessionCubit: context.read<SessionCubit>()),
                  child: const DashboardPage(),
                ))
              ]
            ],
            onPopPage: (route, result) => route.didPop(result),
          );
        }),
      ),
    );
  }
}
