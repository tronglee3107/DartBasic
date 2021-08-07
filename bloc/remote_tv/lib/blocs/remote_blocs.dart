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

  //listen to the event from the UI
  RemoteBloc() {
    eventController.stream.listen((RemoteEvent event) {
      if (event is IncrementEvent) {
        state = RemoteState(state.volumn + event.increment);
      } else if (event is DecrementEvent) {
        state = RemoteState(state.volumn - event.decrement);
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
