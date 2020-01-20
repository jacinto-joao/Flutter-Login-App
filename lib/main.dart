import 'package:blogin_two_login/bloc/authentication/authentication_bloc.dart';
import 'package:blogin_two_login/bloc/authentication/authentication_event.dart';
import 'package:blogin_two_login/bloc/authentication/authentication_state.dart';
import 'package:blogin_two_login/repositories/user_repository.dart';
import 'package:blogin_two_login/ui/app/app.dart';
import 'package:blogin_two_login/ui/home/home_screen.dart';
import 'package:blogin_two_login/ui/loader/loading_indicator.dart';
import 'package:blogin_two_login/ui/login/login_screen.dart';
import 'package:blogin_two_login/ui/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition event) {
    super.onTransition(bloc, event);
    print(event);
  }

  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(stacktrace);
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = AppBlocDelegate();
  final userRepository = UserRepository();
  runApp(BlocProvider<AuthenticationBloc>(
    create: (context) =>
        AuthenticationBloc(userRepository: userRepository)..add(AppStarted()),
    child: MyApp(userRepository: userRepository),
  ));
}

class MyApp extends StatelessWidget {
  final UserRepository _userRepository;
  // This widget is the root of your application.
  MyApp({Key key, UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login Appß',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
        if (state is AuthenticationUninitialized) {
          return SplashScreen();
        }

        if (state is AuthenticationAuthenticated) {
          return HomeScreen();
        }

        if (state is AuthenticationUnauthenticated) {
          return LoginScreen(userRepository: _userRepository);
        }

        if (state is AuthenticationLoading) {
          return LoadingIndicator();
        }
      }),
    );
  }
}
