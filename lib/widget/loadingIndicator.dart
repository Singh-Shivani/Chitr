import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final bool isLoading;
  const LoadingIndicator({Key key, @required this.isLoading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 24),
        width: double.infinity,
        height: 30,
        child: isLoading
            ? CircularProgressIndicator()
            : Center(child: Text("No Image Found")),
      ),
    );
  }
}
