import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final String errorMessage;
  final Function tryAgain;
  const ErrorScreen(
      {Key key, @required this.errorMessage, @required this.tryAgain})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.error,
          color: Colors.grey,
          size: 34,
        ),
        SizedBox(
          height: 21,
        ),
        Text(
          errorMessage,
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(
          height: 16,
        ),
        ElevatedButton(
          child: Text("Try Again"),
          onPressed: () {
            tryAgain(1);
          },
        ),
      ],
    );
  }
}
