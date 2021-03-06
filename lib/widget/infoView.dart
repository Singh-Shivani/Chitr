import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GlowingProgressIndicator(
        child: Icon(
          Icons.headset_rounded,
          size: 55,
          color: Theme.of(context).accentColor,
        ),
      ),
    );
  }
}

class ErrorView extends StatelessWidget {
  final String errorMessage;
  final Function function;
  const ErrorView(
      {Key key, @required this.errorMessage, @required this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElasticIn(
          child: Icon(
            Icons.error,
            size: 55,
            color: Colors.red,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Text(errorMessage),
        SizedBox(
          height: 8,
        ),
        OutlineButton(
          onPressed: function,
          child: Text("Try Again"),
        )
      ],
    ));
  }
}
