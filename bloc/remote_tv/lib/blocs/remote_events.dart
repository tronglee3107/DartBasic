import 'package:equatable/equatable.dart';

class RemoteEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class IncrementEvent extends RemoteEvent {
  final int increment;
  IncrementEvent(this.increment);
}

class DecrementEvent extends RemoteEvent {
  final int decrement;
  DecrementEvent(this.decrement);
}

class MuteEvent extends RemoteEvent {}
