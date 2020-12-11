import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'scrolling_alert_state.dart';

/// Because changes to the [state] of the [response button(s)] is dynamic base on [scrolled to bottom] action,
/// this [cubit] handles [button enable/disable] state

class ScrollingAlertCubit extends Cubit<ScrollingAlertState> {
  ScrollingAlertCubit() : super(ScrollingAlertInitial());

  void setButton({@required bool state}) {
    emit(SetButtonEnabled(state));
  }
}
