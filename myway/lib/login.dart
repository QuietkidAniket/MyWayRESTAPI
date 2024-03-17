import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:junkee/details.dart';
import 'package:junkee/global.dart';
import 'package:junkee/location.dart';
import 'package:junkee/otpverification.dart';

class SignupScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  Future<void> sendData(String name, String age, String height, String weight, String email, String username) async {
    final url = Uri.parse('$baseurl/signup');
    final response = await http.post(
      url,
      body: jsonEncode({
        'name': name,
        'age': age,
        'height': height,
        'weight': weight,
        'email': email,
        'username': username,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      print('Data sent successfully');
    } else {
      print('Failed to send data. Error: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'Name',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(height: 20),
            Container(
  decoration: BoxDecoration(
    color: Color.fromARGB(255, 255, 255, 255),
    border: Border.all(color: Colors.grey),
    borderRadius: BorderRadius.circular(8),
  ),
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.0),
    child: TextField(
      controller: nameController,
      onChanged: (value) {
        // The entered phone number is automatically stored in phoneNumberController.text
      },
      keyboardType: TextInputType.name, // Set keyboard type to phone
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.singleLineFormatter, // Accept only digits
      ],
      decoration: InputDecoration(
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(vertical: 12.0),
      ),
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
),
Text(
              'Age',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(height: 20),
            Container(
  decoration: BoxDecoration(
    color: Color.fromARGB(255, 255, 255, 255),
    border: Border.all(color: Colors.grey),
    borderRadius: BorderRadius.circular(8),
  ),
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.0),
    child: TextField(
      controller: ageController,
      onChanged: (value) {
        // The entered phone number is automatically stored in phoneNumberController.text
      },
      keyboardType: TextInputType.phone, // Set keyboard type to phone
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly, // Accept only digits
      ],
      decoration: InputDecoration(
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(vertical: 12.0),
      ),
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
),
Text(
              'Height',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(height: 20),
            Container(
  decoration: BoxDecoration(
    color: Color.fromARGB(255, 255, 255, 255),
    border: Border.all(color: Colors.grey),
    borderRadius: BorderRadius.circular(8),
  ),
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.0),
    child: TextField(
      controller: heightController,
      onChanged: (value) {
        // The entered phone number is automatically stored in phoneNumberController.text
      },
      keyboardType: TextInputType.phone, // Set keyboard type to phone
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly, // Accept only digits
      ],
      decoration: InputDecoration(
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(vertical: 12.0),
      ),
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
),
Text(
              'Weight',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(height: 20),
            Container(
  decoration: BoxDecoration(
    color: Color.fromARGB(255, 255, 255, 255),
    border: Border.all(color: Colors.grey),
    borderRadius: BorderRadius.circular(8),
  ),
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.0),
    child: TextField(
      controller: weightController,
      onChanged: (value) {
        // The entered phone number is automatically stored in phoneNumberController.text
      },
      keyboardType: TextInputType.phone, // Set keyboard type to phone
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly, // Accept only digits
      ],
      decoration: InputDecoration(
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(vertical: 12.0),
      ),
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
),
Text(
              'Email',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(height: 20),
            Container(
  decoration: BoxDecoration(
    color: Color.fromARGB(255, 255, 255, 255),
    border: Border.all(color: Colors.grey),
    borderRadius: BorderRadius.circular(8),
  ),
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.0),
    child: TextField(
      controller: emailController,
      onChanged: (value) {
        // The entered phone number is automatically stored in phoneNumberController.text
      },
      keyboardType: TextInputType.emailAddress, // Set keyboard type to phone
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.singleLineFormatter, // Accept only digits
      ],
      decoration: InputDecoration(
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(vertical: 12.0),
      ),
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
),
Text(
              'UserName',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(height: 20),
            Container(
  decoration: BoxDecoration(
    color: Color.fromARGB(255, 255, 255, 255),
    border: Border.all(color: Colors.grey),
    borderRadius: BorderRadius.circular(8),
  ),
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.0),
    child: TextField(
      controller: usernameController,
      onChanged: (value) {
        // The entered phone number is automatically stored in phoneNumberController.text
      },
      keyboardType: TextInputType.name, // Set keyboard type to phone
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.singleLineFormatter, // Accept only digits
      ],
      decoration: InputDecoration(
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(vertical: 12.0),
      ),
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final name = nameController.text;
                final age = ageController.text;
                final height = heightController.text;
                final weight = weightController.text;
                final email = emailController.text;
                final username = usernameController.text;
                sendData(name, age, height, weight, email, username);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LocationPage(fullName: name, phoneNumber: '')
                  ),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color(0xff00926d)), // Change button color to green
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0), // Adjust border radius
                  ),
                ),
                minimumSize: MaterialStateProperty.all<Size>(Size(double.infinity, 60)), // Increase button height
              ),
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
