// Copyright 2020 LTMM. All rights reserved.
// Uses of this source code is governed by 'The Unlicense' that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

abstract class ScrollAlertButtonWidget {
  Function onTap();
  Widget body;
  Widget makeButton(BuildContext context, bool makeActive);
}

/// The [ScrollingAlertDialog] requires this [special use Button] for the [response actions] that sit
/// at the bottom of the [Alert Dialog]. This button wraps the [button body](typically a [Text] widget), and a
/// [user callback] around a [Navigator pop()] command to dismiss the dialog.

class ScrollAlertButton implements ScrollAlertButtonWidget {
  ScrollAlertButton({
    @required this.body,
    @required this.onTapCallback,
  })  : assert(body != null),
        assert(onTapCallback != null);

  @override
  Function onTap() => onTapCallback();

  final Function() onTapCallback;

  @override
  Widget body;

  @override
  Widget makeButton(BuildContext context, bool makeActive) {
    return FlatButton(
        child: body,
        onPressed: !makeActive
            ? null
            : () {
                Navigator.of(context, rootNavigator: true).pop();
                Future.delayed(Duration(milliseconds: 200), () {
                  onTap();
                });
              });
  }
}
