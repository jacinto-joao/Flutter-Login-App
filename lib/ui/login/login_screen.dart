import 'package:blogin_two_login/bloc/authentication/authentication_bloc.dart';
import 'package:blogin_two_login/bloc/login/login_bloc.dart';
import 'package:blogin_two_login/repositories/user_repository.dart';
import 'package:blogin_two_login/ui/login/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  final UserRepository _userRepository;

  const LoginScreen({Key key, UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(
              authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
              userRepository: _userRepository),
          child: LoginForm(
            userRepository: _userRepository,
          ),
        ));
  }
}
