// Copyright 2020 LTMM. All rights reserved.
// Uses of this source code is governed by 'The Unlicense' that can be
// found in the LICENSE file.

part of 'scrolling_alert_cubit.dart';

enum ScrollingAlertType {
  ScrollingAlertInitial,
  SetButtonEnabled,
}

@immutable
abstract class ScrollingAlertState extends Equatable {
  final ScrollingAlertType scrollingAlertType;
  const ScrollingAlertState(this.scrollingAlertType);
  @override
  List<Object> get props => [scrollingAlertType];
}

class ScrollingAlertInitial extends ScrollingAlertState {
  const ScrollingAlertInitial() : super(ScrollingAlertType.ScrollingAlertInitial);
}

class SetButtonEnabled extends ScrollingAlertState {
  final bool state;
  const SetButtonEnabled(this.state) : super(ScrollingAlertType.SetButtonEnabled);
  @override
  List<Object> get props => [state, scrollingAlertType];
}
