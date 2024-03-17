import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:junkee/confirmation.dart';
import 'package:junkee/orders.dart';
import 'package:junkee/process_timeline.dart';
import 'package:junkee/global.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;

class CheckoutPage extends StatelessWidget {
  final int progressIndex;
  final String itemCountsString;
  final String address;
  final DateTime date;
  final TimeOfDay time;
  final String? selectedImagePath;

  CheckoutPage({
    required this.progressIndex,
    required this.itemCountsString,
    required this.address,
    required this.date,
    required this.time,
    this.selectedImagePath,
  });

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            child: ProcessTimelinePage(progressIndex: 3),
          ),
          SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    SelectedItemsWidget(
            itemCountsString: itemCountsString,
          ),
                    SizedBox(height: 10),
                    CheckboxListTile(
                      title: Text('Cash on Delivery'),
                      value: false, // Initial value of checkbox
                      onChanged: (newValue) {
                        // Handle checkbox state change
                      },
                    ),
                    AddressInputField(),
                    SizedBox(height: 10),
                    SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: () async {String imagePath = selectedImagePath ?? ""; // Ensure selectedImagePath is not null
    File imageFile = File(imagePath);
    List<int> imageBytes = await imageFile.readAsBytes();

    // Encode the image data as base64
    String base64Image = base64Encode(imageBytes);

    // Send pickup data to the server
    await sendPickupDataToServer(context, base64Image);
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Color(0xff00926d),
                        ), // Change button color to green
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0), // Adjust border radius
                          ),
                        ),
                        minimumSize: MaterialStateProperty.all<Size>(
                            Size(double.infinity, 60)), // Increase button height
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
          ),
        ],
      ),
    );
  }

String generatePickupId() {
  // Get the current date
  DateTime now = DateTime.now();
  String year = now.year.toString();
  String month = now.month.toString().padLeft(2, '0');
  String day = now.day.toString().padLeft(2, '0');

  // Generate random 3 letters
  String letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  String randomLetters = '';
  Random random = Random();
  for (int i = 0; i < 3; i++) {
    randomLetters += letters[random.nextInt(letters.length)];
  }

  // Generate random 3 digit number
  String randomDigits = random.nextInt(1000).toString().padLeft(3, '0');

  // Concatenate all parts to form the pickup_id
  String pickupId = '$year$month$day$randomLetters$randomDigits';

  return pickupId;
}
  String generateOTP() {
    // Generate a random 6-digit OTP
    Random random = Random();
    String otp = '';
    for (int i = 0; i < 6; i++) {
      otp += random.nextInt(10).toString();
    }
    return otp;
  }

  Future<void> sendPickupDataToServer(BuildContext context, String base64Image) async {
  try {
    // Prepare the data to be sent
    String otp = generateOTP();
    String date1 = date.toString();
    DateTime originalDate = DateTime.parse(date1);
    String formattedDate =
        "${originalDate.year}-${originalDate.month.toString().padLeft(2, '0')}-${originalDate.day.toString().padLeft(2, '0')}";
    print(itemCountsString);
    TimeOfDay originalTimeOfDay = time;
    String formattedTime =
        '${originalTimeOfDay.hour.toString().padLeft(2, '0')}:${originalTimeOfDay.minute.toString().padLeft(2, '0')}:00';
    print(formattedTime.toString());
    String pickupId = generatePickupId();
    print(pickupId);
    var pickupData = {
      'pickup_id': pickupId,
      'user_id': user_id,
      'itemCounts': itemCountsString,
      'address': address,
      'date': formattedDate.toString(),
      'time': formattedTime.toString(),
      'otp': otp,
      'imageData': base64Image, // Send the base64-encoded image data
    };

    // Send the data to the server
    var response = await http.post(
      Uri.parse('$baseurl/insert_pickup'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(pickupData),
    );

    // Check the response from the server
    if (response.statusCode == 200) {
      // If the data was successfully sent, navigate to the confirmation page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ConfirmPage(
            pickupId: '$pickupId', // Provide the pickup ID from the server
            pickupDate: '$formattedDate, $formattedTime', // Format the pickup date and time accordingly
          ),
        ),
      );
    } else {
      // If the request was unsuccessful, display an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to save pickup data'),
        ),
      );
    }
  } catch (e) {
    // If an error occurs during the request, display an error message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error: $e'),
      ),
    );
  }
}
}



class AddressInputField extends StatefulWidget {
  @override
  _AddressInputFieldState createState() => _AddressInputFieldState();
}

class _AddressInputFieldState extends State<AddressInputField> {
  late TextEditingController _addressController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _addressController = TextEditingController();
    fetchAddressData();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _addressController,
              readOnly: !_isEditing,
              decoration: InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          IconButton(
            icon: Icon(_isEditing ? Icons.check : Icons.edit),
            onPressed: () {
              setState(() {
                _isEditing = !_isEditing;
                if (!_isEditing) {
                  saveAddressData();
                }
              });
            },
          ),
        ],
      ),
    );
  }

  Future<void> fetchAddressData() async {
    try {
      var response = await http.get(Uri.parse('$baseurl/get_address?user_id=$user_id'));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        setState(() {
          _addressController.text = _formatAddress(data);
        });
      } else {
        print('Failed to fetch address data: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception occurred while fetching address data: $e');
    }
  }

  String _formatAddress(Map<String, dynamic> data) {
    return '${data['address'] ?? ''}, ${data['city'] ?? ''}, ${data['district'] ?? ''}, ${data['pinCode'] ?? ''}, ${data['state'] ?? ''}';
  }

  Future<void> saveAddressData() async {
    try {
      List<String> addressFields = _addressController.text.split(', ');
      if (addressFields.length == 5) {
        String address = addressFields[0];
        String city = addressFields[1];
        String district = addressFields[2];
        String pinCode = addressFields[3];
        String state = addressFields[4];

        var response = await http.post(
          Uri.parse('$baseurl/receive_address'),
          body: json.encode({
            'address': address,
            'city': city,
            'district': district,
            'pinCode': pinCode,
            'state': state,
          }),
          headers: {'Content-Type': 'application/json'},
        );

        if (response.statusCode == 200) {
          print('Address data saved successfully');
        } else {
          print('Failed to save address data: ${response.statusCode}');
        }
      } else {
        print('Incomplete address data');
      }
    } catch (e) {
      print('Exception occurred while saving address data: $e');
    }
  }

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }
}

class SelectedItemsWidget extends StatelessWidget {
  final String itemCountsString;

  SelectedItemsWidget({
    required this.itemCountsString,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Selected Items',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        FutureBuilder<Map<String, dynamic>>(
          future: fetchSelectedItemsWithPrices(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // Show loading indicator while fetching itemized bill
            }
            if (snapshot.hasData) {
              // Display itemized bill
              Map<String, dynamic> itemizedBill = snapshot.data!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Display each item and its price
                  for (var entry in itemizedBill.entries)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(entry.key),
                          Text('Rs ${entry.value.toStringAsFixed(2)}'),
                        ],
                      ),
                    ),
                  SizedBox(height: 16),
                  // Display the total price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Price:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Rs ${calculateTotalPriceFromBill(itemizedBill).toStringAsFixed(2)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text(
                'Error',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              );
            } else {
              return Text('');
            }
          },
        ),
      ],
    );
  }

  Future<Map<String, dynamic>> fetchSelectedItemsWithPrices() async {
    try {
      // Your existing map of categories and items
      Map<String, List<String>> _itemLists = {
        'Paper': ['Newspaper', 'Magazine', 'Cardboard', 'Books', 'Office Paper', 'Paper Bags', 'Paper Cups', 'Paper Plates', 'Paper Towels', 'Paper Napkins', 'Paper Boxes', 'Paper Wrappers'],
        'Clothes': ['Item 4', 'Item 5', 'Item 6'],
        'Plastic': ['Item 7', 'Item 8', 'Item 9'],
        'E-waste': ['Item 10', 'Item 11', 'Item 12'],
        'Metal': ['Item 13', 'Item 14', 'Item 15'],
        'Glass': ['Item 16', 'Item 17', 'Item 18'],
        'Motor': ['Item 19', 'Item 20', 'Item 21'],
        'Other': ['Item 22', 'Item 23', 'Item 24'],
      };

      // Define the map of rates per kilogram for each item
      Map<String, double> itemRates = {
        'Newspaper': 2.0,
        'Magazine': 3.0,
        'Cardboard': 1.5,
        'Books': 4.0,
        'Office Paper': 2.5,
        'Paper Bags': 1.0,
        'Paper Cups': 1.2,
        'Paper Plates': 1.3,
        'Paper Towels': 1.0,
        'Paper Napkins': 1.0,
        'Paper Boxes': 1.5,
        'Paper Wrappers': 0.8,
        'Item 4': 2.5, // Sample rate for Clothes
        'Item 5': 3.0,
        'Item 6': 2.0,
        'Item 7': 1.8, // Sample rate for Plastic
        'Item 8': 2.0,
        'Item 9': 1.5,
        'Item 10': 3.0, // Sample rate for E-waste
        'Item 11': 3.5,
        'Item 12': 4.0,
        'Item 13': 4.0, // Sample rate for Metal
        'Item 14': 4.5,
        'Item 15': 5.0,
        'Item 16': 3.5, // Sample rate for Glass
        'Item 17': 4.0,
        'Item 18': 3.0,
        'Item 19': 6.0, // Sample rate for Motor
        'Item 20': 7.0,
        'Item 21': 5.0,
        'Item 22': 2.0, // Sample rate for Other
        'Item 23': 1.5,
        'Item 24': 2.5,
      };

      // Split the itemCountsString by '|'
      List<String> itemCountsList = itemCountsString.split('|');

      Map<String, dynamic> itemizedBill = {};

      int categoryIndex = 0;
      // Iterate through the _itemLists map
      _itemLists.forEach((category, items) {
        String categoryCounts = itemCountsList[categoryIndex];
        for (int i = 0; i < items.length; i++) {
          // Get the count of the item from categoryCounts
          int count = int.parse(categoryCounts[i]);
          if (count > 0) {
            // If count is greater than zero, calculate the total price for the item and add it to itemizedBill
            double ratePerKg = itemRates[items[i]] ?? 0.0; // Get the rate per kilogram for the item
            double totalPrice = count * ratePerKg;
            itemizedBill[items[i]] = totalPrice;
          }
        }
        categoryIndex++;
      });

      return itemizedBill;
    } catch (e) {
      print('Error fetching selected items with prices: $e');
      throw e;
    }
  }

  double calculateTotalPriceFromBill(Map<String, dynamic> itemizedBill) {
    double totalPrice = 0;
    itemizedBill.forEach((key, value) {
      totalPrice += value;
    });
    return totalPrice;
  }
}
