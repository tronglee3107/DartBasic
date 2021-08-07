import 'blocs/remote.dart';

import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final bloc = RemoteBloc();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Bloc Remote TV'),
        ),
        body: Center(
          child: StreamBuilder<RemoteState>(
            stream: bloc.stateController.stream,
            initialData: bloc.state,
            builder:
                (BuildContext context, AsyncSnapshot<RemoteState> snapshot) {
              return Text(
                  'Âm lượng hiện tại: ${snapshot.data.volume}'); // update UI <=== new
            },
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              onPressed: () =>
                  bloc.eventController.sink.add(IncrementEvent(30)),
              child: Icon(Icons.volume_up),
            ),
            FloatingActionButton(
              onPressed: () =>
                  bloc.eventController.sink.add(DecrementEvent(30)),
              child: Icon(Icons.volume_down),
            ),
            FloatingActionButton(
              onPressed: () => bloc.eventController.sink.add(MuteEvent()),
              child: Icon(Icons.volume_mute),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose(); // dispose bloc <=== new
  }
}
