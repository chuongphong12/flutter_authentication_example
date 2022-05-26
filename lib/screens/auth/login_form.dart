import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttter_authentication/blocs/login/login_bloc.dart';
import 'package:fluttter_authentication/repository/auth_repositories.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../configs/theme.dart' as Styles;

class LoginForm extends StatefulWidget {
  final AuthRepositories _authRepositories;
  const LoginForm({Key? key, required AuthRepositories authRepositories})
      : _authRepositories = authRepositories,
        super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    void _onButtonPressed() async {
      if (_formKey.currentState!.validate()) {
        BlocProvider.of<LoginBloc>(context).add(
          LoginButtonPressed(
            email: _emailController.text,
            password: _passwordController.text,
          ),
        );
      }
    }

    return BlocConsumer<LoginBloc, LoginState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              right: 20,
              left: 20,
              top: 80,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    height: 200,
                    padding: const EdgeInsets.only(
                      bottom: 20,
                      top: 40,
                    ),
                    child: Column(
                      children: const [
                        Text(
                          'Auth With Rest',
                          style: TextStyle(
                            color: Styles.Colors.mainColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Login app using Bloc pattern and rest api',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black38,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    controller: _emailController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        EvaIcons.emailOutline,
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Styles.Colors.mainColor),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 15),
                      labelText: 'E-mail',
                      labelStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    controller: _passwordController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        EvaIcons.lockOutline,
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Styles.Colors.mainColor),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 15),
                      labelText: 'Password',
                      labelStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 15),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {},
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Forgot password?',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      bottom: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: 45,
                          child: RoundedLoadingButton(
                            onPressed: _onButtonPressed,
                            controller: _btnController,
                            color: Styles.Colors.mainColor,
                            resetDuration: const Duration(seconds: 1),
                            resetAfterDuration: true,
                            borderRadius: 15,
                            child: const Text('LOG IN'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Or connect using',
                        style: TextStyle(
                          color: Colors.black26,
                          fontSize: 12,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: 40,
                        width: 160,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            primary: Styles.Colors.mainColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                EvaIcons.facebook,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                "Facebook",
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        width: 160,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            primary: const Color(0xFFF14436),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                EvaIcons.google,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                "Google",
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: const [
                          Text(
                            'Don\' have an account?',
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(width: 5),
                          Text(
                            'Register',
                            style: TextStyle(
                              color: Styles.Colors.mainColor,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 30)
                ],
              ),
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is LoginFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
    );
  }
}
