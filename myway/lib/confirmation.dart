import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:junkee/global.dart';
import 'package:junkee/homepage.dart';
class ConfirmPage extends StatefulWidget {
  final String pickupId;
  final String pickupDate;

  ConfirmPage({
    required this.pickupId,
    required this.pickupDate,
  });

  @override
  _ConfirmPageState createState() => _ConfirmPageState();
}

class _ConfirmPageState extends State<ConfirmPage> {
  late String pickupAddress = ''; // Initialize with an empty string
  static const IconData customIcon = IconData(0xf635, fontFamily: 'MaterialIcons');

  @override
  void initState() {
    super.initState();
    fetchPickupAddress();
  }

  Future<void> fetchPickupAddress() async {
    try {
      var response = await http.get(Uri.parse('$baseurl/get_address?user_id=$user_id'));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        setState(() {
          pickupAddress = _formatAddress(data); // Ensure the value is not null
        });
      } else {
        print('Failed to fetch pickup address: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception occurred while fetching pickup address: $e');
    }
  }
  String _formatAddress(Map<String, dynamic> data) {
    return '${data['address'] ?? ''}, ${data['city'] ?? ''}, ${data['district'] ?? ''}, ${data['pinCode'] ?? ''}, ${data['state'] ?? ''}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary_color,
        title: Text('Confirm Pickup', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  color: primary_color,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          customIcon, // Use the constant IconData
                          color: Colors.white,
                          size: 68,
                        ),
                        SizedBox(height: 16),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Great",
                                style: TextStyle(
                                  fontSize: 38,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Your pickup request has been confirmed, thanks for contributing to clean environment',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 212, 212, 212),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pickup ID:',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          SizedBox(height: 4),
                          Text(widget.pickupId, style: TextStyle(fontSize: 22)),
                          SizedBox(height: 10),
                          Divider(),
                          SizedBox(height: 10),
                          Text(
                            'Pickup Address:',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          SizedBox(height: 4),
                          Text(pickupAddress, style: TextStyle(fontSize: 22)),
                          SizedBox(height: 10),
                          Divider(),
                          SizedBox(height: 10),
                          Text(
                            'Pickup Date:',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          SizedBox(height: 4),
                          Text(widget.pickupDate, style: TextStyle(fontSize: 22)),

                        ],
                      ),
                    ),
                    )
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
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
                          // Adjust border radius
                        ),
                      ),
                      minimumSize: MaterialStateProperty.all<Size>(
                          Size(double.infinity, 60)),
                      // Increase button height
                    ),
                    child: Text('Confirm'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
