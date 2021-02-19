import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'otp_verification_screen.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final TextEditingController _phoneNumberController = TextEditingController();
final TextEditingController _smsController = TextEditingController();

class OtpScreen extends StatelessWidget {
  TextEditingController _controller = TextEditingController();

  set doubleVar(double doubleVar) {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        title: Text('Phone Auth'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(children: [
            Container(
              margin: EdgeInsets.only(top: 60),
              child: Center(
                child: Text(
                  'Phone Authentication',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 30, right: 30),
              margin: EdgeInsets.only(top: 40, right: 10, left: 10),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Enter Phone Number',
                  hintText: '3000000000',
                  prefix: Padding(
                    padding: EdgeInsets.all(4),
                    child: Text('+92'),
                  ),
                  icon: Icon(Icons.phone),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a number';
                  } else {
                    return value.length < 10
                        ? 'Enter at least 10 digits'
                        : null;
                  }
                },
                // decoration: InputDecoration(
                //   hintText: 'Phone Number',
                //   prefix: Padding(
                //     padding: EdgeInsets.all(4),
                //     child: Text('+92'),
                //   ),
                // ),
                // validator: (value) {
                //   if (value.isEmpty) {
                //     return 'Please enter a number';
                //   } else {
                //     return value.length < 10
                //         ? 'Enter at least 10 digits'
                //         : null;
                //   }
                // },
                maxLength: 10,
                keyboardType: TextInputType.number,
                controller: _controller,
              ),
            )
          ]),
          Container(
            padding: EdgeInsets.only(left: 110, right: 110),
            margin: EdgeInsets.all(10),
            width: double.infinity,
            child: RaisedButton(
              color: Colors.green,
              onPressed: () {
                if (_controller.text.length == 10)
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          OtpVerificationScreen(_controller.text)));
              },
              child: Text(
                'Get OTP',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
