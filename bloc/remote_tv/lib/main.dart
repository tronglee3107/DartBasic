import 'blocs/remote.dart';

void main() async {
  //define a bloc object
  final bloc = RemoteBloc();
  print('this is the initial time: ${bloc.state.volumn}');
  //listen to the state to UI
  bloc.stateController.stream.listen((RemoteState state) {
    print('this is the curent volumn: ${bloc.state.volumn}');
  });

  // after 3s increase the volumn
  await Future.delayed(Duration(seconds: 3));
  bloc.eventController.sink.add(IncrementEvent(30));

  //after 5s decrease the volumn
  await Future.delayed(Duration(seconds: 5));
  bloc.eventController.sink.add(DecrementEvent(20));

  //after 5s mute
  await Future.delayed(Duration(seconds: 5));
  bloc.eventController.sink.add(MuteEvent());
}
