import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:blogin_two_login/helpers/validators.dart';
import 'package:rxdart/rxdart.dart';
import 'package:blogin_two_login/bloc/authentication/authentication_event.dart';
import 'package:meta/meta.dart';

import 'package:blogin_two_login/bloc/authentication/authentication_bloc.dart';
import 'package:blogin_two_login/repositories/user_repository.dart';
import './login.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository _userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc(
      {@required UserRepository userRepository,
      @required this.authenticationBloc})
      : assert(userRepository != null),
        assert(authenticationBloc != null),
        _userRepository = userRepository;

  @override
  LoginState get initialState => LoginState.empty();

  @override
  Stream<LoginState> transformEvents(
    Stream<LoginEvent> events,
    Stream<LoginState> Function(LoginEvent event) next,
  ) {
    final nonDebounceStream = events.where((event) {
      return (event is! EmailChanged && event is! PasswordChanged);
    });
    final debounceStream = events.where((event) {
      return (event is EmailChanged || event is PasswordChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      next,
    );
  }

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is LoginButtonPressed) {
      // yield LoginLoadingState();

      yield* _mapLoginWithCredentials(
          email: event.username, password: event.password);

      /*
      try {
        final token = await _userRepository.authenticate(
            username: event.username, password: event.password);

        authenticationBloc.add(LoggedIn(token: token));

        yield InitialLoginState();
      } catch (e) {
        yield LoginFailureState(error: e.toString());
      }*/
    }
  }

  Stream<LoginState> _mapEmailChangedToState(String email) async* {
    yield state.update(isEmailValid: Validators.isValidEmail(email));
  }

  Stream<LoginState> _mapPasswordChangedToState(String password) async* {
    yield state.update(isPasswordValid: Validators.isValidPassword(password));
  }

  Stream<LoginState> _mapLoginWithCredentials(
      {String email, dynamic password}) async* {
    yield LoginState.loading();

    try {
      await _userRepository.authenticate(username: email, password: password);
      yield LoginState.success();
    } catch (_) {
      yield LoginState.failure();
    }
  }
}
