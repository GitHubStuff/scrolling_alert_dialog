import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'scrolling_alert_state.dart';

class ScrollingAlertCubit extends Cubit<ScrollingAlertState> {
  ScrollingAlertCubit() : super(ScrollingAlertInitial());

  void setButton({@required bool state}) {
    emit(SetButtonEnabled(state));
  }
}
