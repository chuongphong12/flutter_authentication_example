import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttter_authentication/blocs/auth/auth_bloc.dart';
import 'package:fluttter_authentication/screens/home/notification_screen.dart';

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Home Screen'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NotificationScreen(),
                  ),
                );
              },
              child: const Text('Notification'),
            ),
            AnimatedTextKit(
              animatedTexts: [
                ScaleAnimatedText(
                  'Then Scale',
                  textStyle:
                      const TextStyle(fontSize: 70.0, fontFamily: 'Canterbury'),
                ),
              ],
              isRepeatingAnimation: true,
            )
          ],
        ),
      ),
    );
  }
}
