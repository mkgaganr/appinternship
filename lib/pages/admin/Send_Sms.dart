import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';



List<String> recipents = ["9945817812"];

class SendSms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Send sms"),),
      body: Container(

        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              color: Theme.of(context).accentColor,
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Text("Send Sms",
                  style: Theme.of(context).accentTextTheme.button),
              onPressed: () {
                _sendSMS("Appointment approved", recipents);
              },
            ),
          ),
        ),

      ),
    );
  }



}

void _sendSMS(String message, List<String> recipents) async {
  String _result = await sendSMS(message: message, recipients: recipents)
      .catchError((onError) {
    print(onError);
  });
  print(_result);
}