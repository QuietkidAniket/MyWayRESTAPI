import 'package:flutter/material.dart';
import 'package:junkee/global.dart';
import 'location.dart';

class UserDetailsPage extends StatefulWidget {
  final String phoneNumber;
  const UserDetailsPage({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  _UserDetailsPageState createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
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
              ' What is your full\n name?',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.3, // Adjust the top position as needed
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(16.0),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'Please enter your full name',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      controller: nameController,
                      onChanged: (value) {
                        // The entered name is automatically stored in nameController.text
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter your full name',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(8),
                      ),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      String fullName = nameController.text;
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LocationPage(
                            fullName: fullName,
                            phoneNumber: widget.phoneNumber,
                          ),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color(0xff00926d)), // Change button color to green
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                      minimumSize: MaterialStateProperty.all<Size>(
                          Size(double.infinity, 60)),
                    ),
                    child: Text(
                      'Save',
                      style: TextStyle(fontSize: 21),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
