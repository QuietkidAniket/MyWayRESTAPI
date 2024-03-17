import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:junkee/checkout.dart';
import 'package:junkee/global.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:junkee/location.dart';
import 'package:junkee/orders.dart';
import 'package:junkee/process_timeline.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class schedulePage extends StatefulWidget {
  final Map<String, Map<String, int>> itemCounts;

  const schedulePage({super.key, required this.itemCounts});

  @override
  _YourPageState createState() => _YourPageState();
}

class _YourPageState extends State<schedulePage> {
  int _processIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pickup Request',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned(
            top: -70,
            left: -150,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width * 0.4,
              child: ProcessTimelinePage(progressIndex: _processIndex),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.12,
            left: 0,
            right: 0,
            bottom: 0,
            child: YourOtherContent(itemCounts: widget.itemCounts),
          ),
        ],
      ),
    );
  }
}

class YourOtherContent extends StatefulWidget {
  final Map<String, Map<String, int>> itemCounts;

  YourOtherContent({required this.itemCounts});
  @override
  _YourOtherContentState createState() => _YourOtherContentState();
}

class _YourOtherContentState extends State<YourOtherContent> {
  int _processIndex = 0;
  late TextEditingController _addressController;
  late Map<String, Map<String, int>> itemCounts;
  late DateTime _selectedDay = DateTime.now();
  late TimeOfDay _selectedTime = TimeOfDay.now();
  late String _itemCountsString;
  List<XFile>? _selectedPhotos;
  final ImagePicker _imagePicker = ImagePicker();
  String? _selectedImagePath;

  @override
  void initState() {
    super.initState();
    _addressController = TextEditingController();
    _itemCountsString = '';// Initialize _itemCounts
    itemCounts=widget.itemCounts;
    fetchAddressData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 17,
          width: 200,
          child: Column(
            children: [
              Divider(
                color: Colors.grey,
                thickness: 2,
              ),
              // Assuming you have a method to display item counts
              // You can call it here or wherever appropriate
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
               AddressInputField(addressController: _addressController),
                SizedBox(height: 20),
              DateSelectionWidget(
                  onSelectDate: (date) {
                    setState(() {
                      _selectedDay = date;
                    });
                  },
                ),
                SizedBox(height: 20),
                TimePickerWidget(
                  onSelectTime: (time) {
                    setState(() {
                      _selectedTime = time;
                    });
                  },
                ),
                _buildPhotoPicker(context),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              _navigateToNextPage();
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                Color(0xff00926d),
              ),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
              minimumSize: MaterialStateProperty.all<Size>(
                Size(double.infinity, 60),
              ),
            ),
            child: Text(
              'Save',
              style: TextStyle(fontSize: 21),
            ),
          ),
        ),
      ],
    );
  }
  

  Widget _buildPhotoPicker(BuildContext context) {
  return Padding(
    padding: EdgeInsets.all(16.0), // Adjust the padding as needed
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(child:
      Text(
                'Help us with the item\'s photo',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
      ),
        AspectRatio(
          aspectRatio: 16 / 9, // Adjust aspect ratio as needed
          child: InkWell(
            onTap: () async {
              await _pickImage(); // No need to capture the result
            },
            child: Container(
              padding: EdgeInsets.all(8.0), // Add padding inside the container
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green), // Green border
                borderRadius: BorderRadius.circular(16.0),
                color: Colors.lightGreen.shade200, // Light green background
              ),
              child: Center(
                child: Text(
                  'Upload Photo',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
            ),
          ),
        ),
        if (_selectedPhotos != null && _selectedPhotos!.isNotEmpty)
          _buildImagePreview(_selectedPhotos!),
      ],
    ),
  );
}

  Widget _buildImagePreview(List<XFile> images) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8),
        Text('Selected Photo:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(
          height: 150,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.file(
              File(images.first.path),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 8),
      ],
    );
  }

  Future<void> _pickImage() async {
  try {
    XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedPhotos = [image];
        _selectedImagePath = image.path; // Store the selected image path
      });
    }
  } catch (e) {
    print('Error picking image: $e');
  }
}


  void fetchAddressData() async {
    try {
      var response =
          await http.get(Uri.parse('$baseurl/get_address?user_id=$user_id'));
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

  void _navigateToNextPage() {
  _populateItemCountsString(itemCounts);
  displayItemCounts();
  print("$_selectedImagePath");
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => CheckoutPage(
        progressIndex: _processIndex + 1,
        itemCountsString: _itemCountsString,
        address: _addressController.text,
        date: _selectedDay,
        time: _selectedTime,
        selectedImagePath: _selectedImagePath, // Pass the selected image path
        // Pass additional data like date, time, and address if needed
      ),
    ),
  );
}

  

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  void displayItemCounts() {
    itemCounts.forEach((category, items) {
      print('Category: $category');
      items.forEach((item, count) {
        print(' - $item: $count');
      });
    });
  }

  void _populateItemCountsString(Map<String, Map<String, int>> itemCounts) {
  // Initialize the string
  _itemCountsString = '';

  // Iterate over the outer map
  itemCounts.forEach((category, items) {

    // Iterate over the inner map
    items.forEach((item, count) {
      // Concatenate item name and count to the string
      _itemCountsString += '$count';
    });

    // Remove the trailing comma and space
    if (items.isNotEmpty) {
      _itemCountsString = _itemCountsString.substring(0, _itemCountsString.length);
    }

    // Add a separator between categories
    _itemCountsString += '|';
  }); 

  // Remove the trailing separator
  if (_itemCountsString.isNotEmpty) {
    _itemCountsString = _itemCountsString.substring(0, _itemCountsString.length - 1);
  }
  print('_itemCountsString: $_itemCountsString');
}


}

class AddressInputField extends StatelessWidget {
  final TextEditingController addressController;

  AddressInputField({required this.addressController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: addressController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // Handle edit address
            },
          ),
        ],
      ),
    );
  }
}

class DateSelectionWidget extends StatefulWidget {
  final Function(DateTime) onSelectDate;

  DateSelectionWidget({required this.onSelectDate});

  @override
  _DateSelectionWidgetState createState() => _DateSelectionWidgetState();
}

class _DateSelectionWidgetState extends State<DateSelectionWidget> {
  late DateTime currentDate;
  late List<DateTime> nextThreeDays;
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    currentDate = DateTime.now();
    nextThreeDays = [
      currentDate,
      currentDate.add(Duration(days: 1)),
      currentDate.add(Duration(days: 2)),
      currentDate.add(Duration(days: 3)),
    ];
    _selectedIndex = -1; // No date selected initially
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16),
        Text(
          "Select a date",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: nextThreeDays.asMap().entries.map((entry) {
            return ElevatedButton(
              onPressed: () {
                setState(() {
                  _selectedIndex = entry.key;
                });
                widget.onSelectDate(entry.value);
              },
              style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(
      _selectedIndex == entry.key ? Colors.blue : Colors.grey,
    ),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0), // Adjust the border radius as needed
      ),
    ),
    minimumSize: MaterialStateProperty.all<Size>(
      Size(100, 50), // Adjust the width and height as needed
    ),
    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
      EdgeInsets.all(10), // Adjust the padding as needed
    ),
    elevation: MaterialStateProperty.all<double>(
      3.0, // Adjust the elevation as needed
    ),
  ),

              child: Column(
                children: [
                  Text(
                    DateFormat.MMM().format(entry.value),
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    DateFormat.d().format(entry.value),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    DateFormat.y().format(entry.value),
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

}

class TimePickerWidget extends StatefulWidget {
  final Function(TimeOfDay) onSelectTime;

  TimePickerWidget({required this.onSelectTime});

  @override
  _TimePickerWidgetState createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
  late TimeOfDay _selectedTime;
  late List<bool> _isSelectedList;

  @override
  void initState() {
    super.initState();
    _selectedTime = TimeOfDay.now();
    _isSelectedList = List.generate(8, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Pick Time',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              8,
              (index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      _selectedTime = TimeOfDay(hour: index, minute: 0);
                      _updateSelectedTimeState(index);
                      widget.onSelectTime(_selectedTime);
                    },
                    child: Container(
                      width: 80,
                      height: 35,
                      decoration: BoxDecoration(
                        color: _isSelectedList[index]
                            ? Colors.blue
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${index.toString().padLeft(2, '0')}:00',
                        style: TextStyle(
                          color: _isSelectedList[index]
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  void _updateSelectedTimeState(int selectedIndex) {
    setState(() {
      _isSelectedList =
          List.generate(8, (index) => index == selectedIndex ? true : false);
    });
  }
}

class PhotoPickerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Text(
          "Help us with the item's photo",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Center(
          child: Container(
            height: 150,
            width: MediaQuery.of(context).size.width * 0.85,
            decoration: BoxDecoration(
              color: Color(0xffE6FFF5),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.green,
                style: BorderStyle.solid,
                width: 2.0,
              ),
            ),
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Tap to Pick Photos',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}