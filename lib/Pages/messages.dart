import 'package:flutter/material.dart';
import 'package:firebase_integration/services/calls_and_messages_service.dart';
import 'package:firebase_integration/services/service_locator.dart';




class Messages extends StatefulWidget {

  @override
  _MessagesState createState() => _MessagesState();
}



class _MessagesState extends State<Messages> {
  final CallsAndMessagesService _service = locator<CallsAndMessagesService>();
  
  final String number = "+12052364208";
  final String email = "aayush21518@gmail.com";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SOS Contacts'),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            RaisedButton(
              child: Text(
                "Call $number",
              ),
              onPressed: () => _service.call(number),
            ),
            SizedBox(height: 20),
            RaisedButton(
              child: Text(
                "Message $number",
              ),
              onPressed: () => _service.sendSms(number),
            ),
            SizedBox(height: 20),
            RaisedButton(
              child: Text(
                "Email $email",
              ),
              onPressed: () => _service.sendEmail(email),
            ),
          ],
        ),
      ),
    );
  }
}
