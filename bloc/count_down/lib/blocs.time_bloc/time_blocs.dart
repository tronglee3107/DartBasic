import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'time.dart';

class TimeBloc extends Bloc<TimeEvent, TimeState> {
  static int _timeduration = 30;

  TimeBloc(TimeState initialState) : super(InitialState(_timeduration));

  StreamSubscription<int> _timeSubscription;

  @override
  Stream<TimeState> mapEventToState(TimeEvent event) async* {
    // TODO: implement mapEventToState
    if (event is StartEvent) {
      yield RunningState(event.timeDuration);
      _timeSubscription?.cancel();

      _timeSubscription = ChangeTime(event.timeDuration).listen((timeDuration) {
        return add(RunEvent(event.timeDuration));
      });
    }
  }

  Stream<int> ChangeTime(int time) {
    return Stream.periodic(Duration(seconds: 1), (x) => time - x - 1)
        .take(time);
  }
}
