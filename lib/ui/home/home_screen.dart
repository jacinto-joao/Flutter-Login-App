import 'package:blogin_two_login/bloc/alert/alert_bloc.dart';
import 'package:blogin_two_login/bloc/alert/alert_state.dart';
import 'package:blogin_two_login/bloc/authentication/authentication_bloc.dart';
import 'package:blogin_two_login/bloc/authentication/authentication_event.dart';
import 'package:blogin_two_login/ui/home/partials/alerts_list.dart';
import 'package:blogin_two_login/ui/login/login_form.dart';
import 'package:blogin_two_login/ui/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) {
          return AlertBloc();
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  //  BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AlertsList()));
                },
                child: Text('Home'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
