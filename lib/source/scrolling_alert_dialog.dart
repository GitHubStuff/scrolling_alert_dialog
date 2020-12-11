// Copyright 2020 LTMM. All rights reserved.
// Uses of this source code is governed by 'The Unlicense' that can be
// found in the LICENSE file.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrolling_alert_dialog/cubit/scrolling_alert_cubit.dart';
import 'package:theme_package/theme_package.dart';

import 'scroll_alert_button.dart';

/// Custom [Alert Widget] that will display [scrolling context] and [response buttons] that are inactive until
/// the user [scrolls] to the bottom of the content.

/// Max [height] of the [SingleChildScrollView] as a percentage of the screen height
const double _sizePercentageOfScrollView = 0.30;

class ScrollingAlertDialog extends StatefulWidget {
  final Widget header;
  final Widget bodyWidget;
  final ScrollAlertButton dismissButton;
  final List<ScrollAlertButton> buttons;

  const ScrollingAlertDialog({
    @required this.header,
    @required this.bodyWidget,
    @required this.dismissButton,
    this.buttons,
  })  : assert(header != null),
        assert(bodyWidget != null),
        assert(dismissButton != null);

  @override
  _ScrollingAlertDialog createState() => _ScrollingAlertDialog();
}

class _ScrollingAlertDialog extends ObservingStatefulWidget<ScrollingAlertDialog> {
  bool _enableWhenScrolledToButtonOfBodyWidget = false;
  ScrollController _scrollController = ScrollController();
  ScrollingAlertCubit _scrollingAlertCubit = ScrollingAlertCubit();

  @override
  void afterFirstLayout(BuildContext context) {
    /// Enable/disable buttons based on the [content] fit in the [SingleChildScrollView]
    _scrollingAlertCubit.setButton(state: _scrollController.position.maxScrollExtent == 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScrollingAlertCubit, ScrollingAlertState>(
      cubit: _scrollingAlertCubit,
      builder: (context, state) {
        switch (state.scrollingAlertType) {
          case ScrollingAlertType.ScrollingAlertInitial:

            /// Add a [listener] that will enable the [buttons] after reaching bottom of the [SingleChildScrollView]
            _scrollController.addListener(() {
              final maxScroll = _scrollController.position.maxScrollExtent;
              if (_scrollController.offset >= maxScroll) {
                _scrollingAlertCubit.setButton(state: true);
              }
            });
            break;
          case ScrollingAlertType.SetButtonEnabled:
            _enableWhenScrolledToButtonOfBodyWidget = (state as SetButtonEnabled).state;
            break;
        }

        /// Build the [List] of [Buttons], if any, then add the [required dismissButton]
        List<Widget> buttons = List();
        if ((widget.buttons ?? List()).isNotEmpty) {
          widget.buttons
              .forEach((sab) => buttons.add(sab.makeButton(context, _enableWhenScrolledToButtonOfBodyWidget)));
        }
        buttons.add(widget.dismissButton.makeButton(context, _enableWhenScrolledToButtonOfBodyWidget));
        bool isAndroid() => Theme.of(context).platform == TargetPlatform.android;
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return !isAndroid()
                ? AlertDialog(
                    actions: buttons,
                    title: widget.header,
                    content: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: viewportConstraints.maxHeight * _sizePercentageOfScrollView,
                      ),
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        child: widget.bodyWidget,
                      ),
                    ),
                  )
                : CupertinoAlertDialog(
                    actions: buttons,
                    title: widget.header,
                    content: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: viewportConstraints.maxHeight * _sizePercentageOfScrollView,
                      ),
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        child: widget.bodyWidget,
                      ),
                    ),
                  );
          },
        );
      },
    );
  }
}
