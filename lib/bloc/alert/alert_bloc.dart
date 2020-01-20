import 'dart:async';
import 'package:bloc/bloc.dart';
import './alert.dart';

class AlertBloc extends Bloc<AlertEvent, AlertState> {
  @override
  AlertState get initialState => InitialAlertState();

  @override
  Stream<AlertState> mapEventToState(
    AlertEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
