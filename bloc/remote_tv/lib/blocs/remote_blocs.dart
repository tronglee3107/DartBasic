import 'dart:async';

import 'remote_events.dart';
import 'remote_states.dart';

class RemoteBloc {
  //define the bloc object
  var state = RemoteState(70);

  //define the controller for the event from UI
  final eventController = StreamController<RemoteEvent>();

  //define the controller for the state to UI
  final stateController = StreamController<RemoteState>();

  bool checkMute() {
    if (state.volume >= 0) {
      return false;
    } else {
      return true;
    }
  }

  bool isNegative() {
    if (state.volume < 0) {
      return true;
    } else {
      return false;
    }
  }

  //listen to the event from the UI
  RemoteBloc() {
    eventController.stream.listen((RemoteEvent event) {
      if (event is IncrementEvent) {
        state = RemoteState(state.volume + event.increment);
      } else if (event is DecrementEvent) {
        if (!checkMute()) {
          state = RemoteState(state.volume - event.decrement);
          if (isNegative()) {
            state = RemoteState(0);
          }
        } else {
          state = RemoteState(state.volume);
        }
      } else if (event is MuteEvent) {
        state = RemoteState(0);
      }

      //send State to the UI
      stateController.sink.add(state);
    });
  }
  void dispose() {
    eventController.close();
    stateController.close();
  }
}
