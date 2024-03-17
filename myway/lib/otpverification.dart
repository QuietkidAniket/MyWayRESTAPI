import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:junkee/details.dart';
import 'package:junkee/global.dart';

class OTPVerificationPage extends StatefulWidget {
  final String phoneNumber;
  const OTPVerificationPage({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  _OTPVerificationPageState createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  List<String> otpDigits = List.filled(6, ''); // List to store each digit of the OTP
  
  Future<void> sendOTP(List<String> otpDigits) async {
    final url = Uri.parse('$baseurl/verify_otp');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'phone_number': widget.phoneNumber,
          'otp_code': otpDigits.join(),
        }),
      );
      if (response.statusCode == 200) {
        // Handle the server response if needed
        print('OTP verification successful');
        // If OTP is valid, you can navigate to the next screen or perform other actions
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => UserDetailsPage(phoneNumber: widget.phoneNumber,)),
        );
      } else {
        // Handle errors
        print('Failed to verify OTP. Error: ${response.statusCode}');
        print(otpDigits.join());
        print(widget.phoneNumber);
        
      }
    } catch (e) {
      // Handle exceptions
      print('Exception during OTP verification: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children:[
          CustomPaint(
            size: Size(
              MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height * 0.6,
            ),
            painter: InclinedBorderPainter(),
          ),
          Positioned(
      top: 40, // Adjust the top position as needed
      left: 20, // Adjust the left position as needed
      child: Text(
        'Enter Verification \nCode',
        style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ),
          Positioned(
            top: screenHeight * 0.25,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(16.0),
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      'Please enter OTP sent to \n+91 xxxxx xxxxx',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        6,
                        (index) => buildOTPDigitBox(index),
                      ),
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: Text(
                        'Resend OTP',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xffB3BC8B),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        await sendOTP(otpDigits);
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(primary_color),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                        ),
                        minimumSize: MaterialStateProperty.all<Size>(Size(0, screenHeight * 0.08)),
                      ),
                      child: Text(
                        'Submit',
                        style: TextStyle(fontSize: 21),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildOTPDigitBox(int index) {
    return Container(
      width: 40,
      height: 40,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: TextFormField(
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
          keyboardType: TextInputType.number,
          maxLength: 1,
          onChanged: (value) {
            setState(() {
              otpDigits[index] = value;
            });
            if (value.isNotEmpty && index < 5) {
              FocusScope.of(context).nextFocus();
            }
          },
          decoration: InputDecoration(
            counter: Offstage(),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
