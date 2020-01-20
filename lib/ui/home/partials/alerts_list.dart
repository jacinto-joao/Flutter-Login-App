import 'package:blogin_two_login/bloc/alert/alert_bloc.dart';
import 'package:blogin_two_login/bloc/alert/alert_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlertsList extends StatefulWidget {
  AlertsList({Key key}) : super(key: key);

  @override
  _AlertsListState createState() => _AlertsListState();
}

class _AlertsListState extends State<AlertsList> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AlertBloc, AlertState>(
      listener: (context, state) {},
      child: BlocBuilder(
        builder: (context, state) {
          return Center(
            child: Text('All Good'),
          );
        },
      ),
    );
  }
}
