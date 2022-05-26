import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttter_authentication/blocs/auth/auth_bloc.dart';
import 'package:fluttter_authentication/blocs/login/login_bloc.dart';
import 'package:fluttter_authentication/firebase_options.dart';
import 'package:fluttter_authentication/repository/auth_repositories.dart';
import 'package:fluttter_authentication/screens/auth/login_screen.dart';
import 'package:fluttter_authentication/screens/home/home_screen.dart';
import 'package:fluttter_authentication/simple_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  BlocOverrides.runZoned(
    () {
      runApp(const MyApp());
    },
    blocObserver: SimpleBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepositories>(
          create: (context) => AuthRepositories(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              authRepositories: context.read<AuthRepositories>(),
            )..add(AppStarted()),
          ),
          BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(
              authRepositories: context.read<AuthRepositories>(),
              authBloc: context.read<AuthBloc>(),
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Authentication',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthAuthenticated) {
                return const HomeScreen();
              }
              if (state is AuthUnAuthenticated) {
                return LoginScreen(
                  authRepositories: context.read<AuthRepositories>(),
                );
              }
              if (state is AuthLoading) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            },
          ),
        ),
      ),
    );
  }
}
