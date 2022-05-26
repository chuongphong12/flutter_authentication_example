import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttter_authentication/blocs/auth/auth_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        actions: [
          IconButton(
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).add(LoggedOut());
            },
            icon: const Icon(EvaIcons.logOut),
          )
        ],
      ),
      body: const Center(
        child: Text('Home Screen'),
      ),
    );
  }
}
