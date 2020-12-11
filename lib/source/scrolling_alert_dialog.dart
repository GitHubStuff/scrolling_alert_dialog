import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrolling_alert_dialog/cubit/scrolling_alert_cubit.dart';
import 'package:theme_package/theme_package.dart';

import 'scroll_alert_button.dart';

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
  void initState() {
    Log.setTrace(baseLevel: LogLevel.All);
    super.initState();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _scrollingAlertCubit.setButton(state: _scrollController.position.maxScrollExtent == 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return _body();
  }

  Widget _body() {
    return BlocBuilder<ScrollingAlertCubit, ScrollingAlertState>(
      cubit: _scrollingAlertCubit,
      builder: (context, state) {
        switch (state.scrollingAlertType) {
          case ScrollingAlertType.ScrollingAlertInitial:
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
        List<Widget> buttons = [widget.dismissButton.makeButton(context, _enableWhenScrolledToButtonOfBodyWidget)];
        if ((widget.buttons ?? List()).isNotEmpty) {
          widget.buttons
              .forEach((sab) => buttons.add(sab.makeButton(context, _enableWhenScrolledToButtonOfBodyWidget)));
        }
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return CupertinoAlertDialog(
              actions: buttons,
              title: widget.header,
              content: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: viewportConstraints.maxHeight * 0.30,
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