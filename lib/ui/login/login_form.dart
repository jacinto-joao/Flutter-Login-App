import 'package:blogin_two_login/bloc/authentication/authentication.dart';
import 'package:blogin_two_login/bloc/login/login_bloc.dart';
import 'package:blogin_two_login/bloc/login/login_event.dart';
import 'package:blogin_two_login/bloc/login/login_state.dart';
import 'package:blogin_two_login/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  final UserRepository _userRepository;

  LoginForm({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginBloc _loginBloc;

  UserRepository get _userRepository => widget._userRepository;

  bool get isPopulated =>
      _usernameController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty;

  bool isLoginButtonEnabled(LoginState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _usernameController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Wrong Login'), Icon(Icons.error)],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }

        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Row(
                children: [
                  Text('Logging in...'),
                  CircularProgressIndicator(),
                ],
              ),
            ));
        }

        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Container(
              child: Center(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          icon: Icon(Icons.email),
                          labelText: 'Email',
                        ),
                        keyboardType: TextInputType.emailAddress,
                        autovalidate: true,
                        autocorrect: false,
                        validator: (_) {
                          return !state.isEmailValid ? 'Invalid Email' : null;
                        },
                      ),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          icon: Icon(Icons.lock),
                          labelText: 'Password',
                        ),
                        obscureText: true,
                        autovalidate: true,
                        autocorrect: false,
                        validator: (_) {
                          return !state.isPasswordValid
                              ? 'Invalid Password'
                              : null;
                        },
                      ),
                      SizedBox(height: 15),
                      RaisedButton(
                        onPressed: state is! LoginLoadingState
                            ? _onLoginButtonPressed
                            : null,
                        child: Text('Login'),
                      ),
                      Container(
                        child: state is LoginLoadingState
                            ? CircularProgressIndicator()
                            : null,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ));
        },
      ),
    );
  }

  Widget _usernameFormField(context, LoginState state) {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Username'),
      controller: _usernameController,
      autovalidate: true,
      validator: (_) {
        return !state.isEmailValid ? 'Invalid email' : null;
      },
    );
  }

  Widget _passwordFormField(context, LoginState state) {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Password'),
      controller: _passwordController,
      autovalidate: true,
      validator: (_) {
        return !state.isPasswordValid ? ' Invalid password' : null;
      },
    );
  }

  void _onLoginButtonPressed() {
    BlocProvider.of<LoginBloc>(context).add(
      LoginButtonPressed(
        username: _usernameController.text,
        password: _passwordController.text,
      ),
    );
    print(_usernameController.text);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _loginBloc.add(EmailChanged(email: _usernameController.text));
  }

  void _onPasswordChanged() {
    _loginBloc.add(PasswordChanged(password: _passwordController.text));
  }

  void _onFormSubmitted() {
    _loginBloc.add(LoginButtonPressed(
        username: _usernameController.text,
        password: _usernameController.text));
  }
}
