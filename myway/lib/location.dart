import 'package:flutter/material.dart';
import 'package:junkee/global.dart';
import 'package:junkee/homepage.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:junkee/homepage.dart';
import 'package:http/http.dart' as http;


class Address {
  final String address;
  final String city;
  final String district;
  final String pinCode;
  final String state;

  Address({
    required this.address,
    required this.city,
    required this.district,
    required this.pinCode,
    required this.state,
  });
}

class LocationPage extends StatelessWidget {
  final String fullName;
  final String phoneNumber;

  const LocationPage({Key? key, required this.fullName,required this.phoneNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            child: FlutterMap(
              options: MapOptions(
                initialCenter: LatLng(13.111886, 80.128164),
                initialZoom: 9.2,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
                RichAttributionWidget(
                  attributions: [
                    TextSourceAttribution(
                      'OpenStreetMap contributors',
                      onTap: () => launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: DraggableSheetWithFixedContent(fullName: fullName, phoneNumber: phoneNumber),
          ),
        ],
      ),
    );
  }
}

class DraggableSheetWithFixedContent extends StatelessWidget {
  final String fullName;
  final String phoneNumber;

  const DraggableSheetWithFixedContent({Key? key, required this.fullName,required this.phoneNumber}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.1,
      minChildSize: 0.1,
      maxChildSize: 0.7,
      builder: (context, controller) {
        return SingleChildScrollView(
          controller: controller,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Add Your Address',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                AddressForm(fullName: fullName, phoneNumber: phoneNumber),
              ],
            ),
          ),
        );
      },
    );
  }
}

class AddressForm extends StatelessWidget {
  final String fullName;
  final String phoneNumber;
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  AddressForm({Key? key, required this.fullName, required this.phoneNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            controller: addressController,
            decoration: InputDecoration(
              hintText: 'Address',
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(8),
            ),
            style: TextStyle(
              fontSize: 17,
            ),
          ),
        ),
        SizedBox(height: 30),
        Container(
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            controller: cityController,
            decoration: InputDecoration(
              hintText: 'City',
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(8),
            ),
            style: TextStyle(
              fontSize: 17,
            ),
          ),
        ),
        SizedBox(height: 30),
        Container(
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            controller: districtController,
            decoration: InputDecoration(
              hintText: 'District',
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(8),
            ),
            style: TextStyle(
              fontSize: 17,
            ),
          ),
        ),
        SizedBox(height: 30),
        Container(
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            controller: pinCodeController,
            decoration: InputDecoration(
              hintText: 'Pin Code',
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(8),
            ),
            style: TextStyle(
              fontSize: 17,
            ),
          ),
        ),
        SizedBox(height: 30),
        Container(
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            controller: stateController,
            decoration: InputDecoration(
              hintText: 'State',
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(8),
            ),
            style: TextStyle(
              fontSize: 17,
            ),
          ),
        ),
        SizedBox(height: 30),
        ElevatedButton(
          onPressed: () async {
  // Create a string containing all address details separated by commas
  /*String fullAddress = '${addressController.text}, ${cityController.text}, ${districtController.text}, ${pinCodeController.text}, ${stateController.text}';

  // Create a map containing the name and full address
  Map<String, String> addressData = {
    'phoneNumber': phoneNumber,
    'name': fullName,
    'fullAddress': fullAddress,
  };
  print(fullName);
  print(fullAddress);
  print(phoneNumber);
  // Convert the address data map to JSON format
  String jsonData = json.encode(addressData);
  print(jsonData);

  try {
    // Make a POST request to your server endpoint with the address data
    var response = await http.post(
      Uri.parse('$baseurl/receive_address'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonData,
    );

    // Check if the request was successful
    if (response.statusCode == 200) {
      // Address saved successfully, navigate to the home page or show a success message
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    } else {
      // Handle errors or display an error message
      print('Failed to save address: ${response.body}');
    }
  } catch (e) {
    // Handle exceptions or display an error message
    print('Exception occurred while saving address: $e');
  }*/
  Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
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
          child: Text('Save Address'),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
