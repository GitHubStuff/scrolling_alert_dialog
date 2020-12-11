import 'package:flutter/material.dart';

abstract class ScrollAlertButtonWidget {
  Function onTap(String tag, dynamic response);
  dynamic response;
  Widget body;
  String tag;
  Widget makeButton(BuildContext context, bool makeActive) {
    return FlatButton(
        child: this.body,
        onPressed: !makeActive
            ? null
            : () {
                onTap(tag, response);
                Navigator.of(context, rootNavigator: true).pop();
              });
  }
}

class ScrollAlertButton implements ScrollAlertButtonWidget {
  ScrollAlertButton({
    @required this.tag,
    @required this.body,
    @required this.onTapFunction,
    @required this.response,
  })  : assert(tag != null),
        assert(body != null),
        assert(onTapFunction != null);

  @override
  Function onTap(String tag, response) => onTapFunction(tag, response);

  final Function(String, dynamic) onTapFunction;

  @override
  Widget body;

  @override
  var response;

  @override
  String tag;

  @override
  Widget makeButton(BuildContext context, bool makeActive) {
    return FlatButton(
      child: body,
      onPressed: !makeActive
          ? null
          : () {
              Navigator.of(context, rootNavigator: true).pop();
              onTap(tag, response);
            },
    );
  }
}
