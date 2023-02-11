import 'package:flutter/material.dart';
import 'dart:async';
import 'package:notifications/notifications.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Notifications? _notifications;
  StreamSubscription<NotificationEvent>? _subscription;
  bool started = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    startListening();
  }

  void onData(NotificationEvent event) {
    print(event.toString());
  }

  void startListening() {
    _notifications = Notifications();
    try {
      _subscription = _notifications!.notificationStream!.listen(onData);
      setState(() => started = true);
    } on NotificationException catch (exception) {
      print(exception);
    }
  }

  void stopListening() {
    _subscription?.cancel();
    setState(() => started = false);
  }

  Widget build(BuildContext context) {
    return new Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: Container(
                padding: EdgeInsets.fromLTRB(0.0, 35.0, 0.0, 35.0),
                child: Chip(
                  elevation: 20,
                  padding: EdgeInsets.all(8),
                  backgroundColor: started ? Colors.blue : Colors.red,
                  shadowColor: Colors.white,
                  label: Text(
                    started ? "Active" : "Inactive",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ), //Text
                ),
              )),
              Container(
                child: Center(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 0.0),
                    child: Image(
                      image: AssetImage("assets/home_icon.png"),
                      height: 150.0,
                    ),
                  ),
                ),
              ),
              Text("Cringe Me Away",
                  style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              Text("Lorem ipsum dolor sit amet elit ",
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              SizedBox(height: 15.0),
              GestureDetector(
                onTap: () {
                  started ? stopListening() : startListening();
                },
                child: Container(
                  height: 40.0,
                  width: 200.0,
                  child: Material(
                    borderRadius: BorderRadius.circular(20.0),
                    shadowColor: Colors.greenAccent,
                    color: Theme.of(context).primaryColor,
                    elevation: 7.0,
                    child: Center(
                      child: Text(
                        started ? 'STOP CRINGING' : 'START CRINGING',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
