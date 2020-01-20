import 'package:blogin_two_login/bloc/alert/alert.dart';
import 'package:equatable/equatable.dart';

abstract class AlertState extends Equatable {
  const AlertState();
}

class InitialAlertState extends AlertState {
  @override
  List<Object> get props => [];
}

class AlertLoadingState extends AlertState {
  final bool isLoading;
  final bool isDoneLoading;

  AlertLoadingState({this.isLoading, this.isDoneLoading});

  @override
  List<Object> get props => [];
}

class AlertLoadedState extends AlertState {
  @override
  List<Object> get props => [];
}

class LoadAlertsState {}
