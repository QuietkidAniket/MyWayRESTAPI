import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:junkee/global.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<List<Widget>> _tabsContent;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabsContent = List.generate(3, (_) => <Widget>[]); // Initialize empty lists for each tab
    _fetchDataForTabs();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Method to calculate total cost based on item count string and rate per kilogram
  double calculateTotalCost(String itemCountsString, double ratePerKg) {
    // Define your item lists
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

    // Split the itemCountsString by '|'
    List<String> itemCountsList = itemCountsString.split('|');
    List<Widget> selectedItemsWidgets = [];
    double totalCost = 0;

    int categoryIndex = 0;
    // Iterate through the _itemLists map
    _itemLists.forEach((category, items) {
      String categoryCounts = itemCountsList[categoryIndex];
      for (int i = 0; i < items.length; i++) {
        // Get the count of the item from categoryCounts
        int count = int.parse(categoryCounts[i]);
        if (count > 0) {
          // If count is greater than zero, add the item to selectedItemsWidgets list
          double totalPrice = count * ratePerKg;
          totalCost += totalPrice;
          // You can build your selected items widgets here if needed
        }
      }
      categoryIndex++;
    });

    // Return the total cost
    return totalCost;
  }

  // Method to calculate total weight based on item count string
  double calculateTotalWeight(String itemCountsString) {
    // Split the itemCountsString by '|'
    List<String> itemCountsList = itemCountsString.split('|');
    double totalWeight = 0;

    // Iterate through the itemCountsList and sum the characters to get the total weight
    itemCountsList.forEach((itemCounts) {
      for (int i = 0; i < itemCounts.length; i++) {
        int count = int.parse(itemCounts[i]);
        totalWeight += count;
      }
    });

    // Return the total weight
    return totalWeight;
  }

  void _fetchDataForTabs() async {
    // Make a GET request to fetch pickup information from the server
    var response = await http.get(Uri.parse('$baseurl/get_pickup_info?user_id=1'));

    if (response.statusCode == 200) {
      // Parse the JSON response
      var data = json.decode(response.body);
      List<TabData> pickupInfo = [];

      // Convert JSON data into TabData objects
      for (var pickup in data['pickup_info']) {
        TabData tabData = TabData(
  collectionId: pickup['pickup_id'],
  totalWeight: 'Total weight: ${calculateTotalWeight(pickup['item_counts'])} kg',
  approxPrice: 'Approx price: \$${calculateTotalCost(pickup['item_counts'], 5.0).toStringAsFixed(2)}',
  itemCountsString: pickup['item_counts'],
  date: pickup['date'],
  time: pickup['time'],
  oTP: pickup['otp'],
  address: pickup['address'], // Parse and store the address
);

        pickupInfo.add(tabData);
      }

      // Update the state with fetched data
      setState(() {
        _tabsContent[0] = _buildTiles(pickupInfo);
        _tabsContent[1] = _buildTiles(pickupInfo);
        _tabsContent[2] = _buildTiles(pickupInfo);
      });
    } else {
      // Handle error
      print('Failed to load pickup information');
    }
  }

  List<Widget> _buildTiles(List<TabData> data) {
    return data.map((item) => buildListItem(item)).toList();
  }

  Widget buildListItem(TabData item) {
    return GestureDetector(
      onTap: () {
        // Navigate to order details page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderDetailsPage(
              order: item,
              itemCountsString: item.itemCountsString, // Placeholder value for itemCountsString
              ratePerKg: 5.0, // Placeholder value for ratePerKg
            ),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                color: primary_color,
                padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                child: Text(
                  'Collection ID: ${item.collectionId}',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              _buildRow('Total weight:', item.totalWeight),
              SizedBox(height: 8.0),
              _buildRow('Approx price:', item.approxPrice),
              SizedBox(height: 8.0),
              _buildRow('OTP:', item.oTP),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Text(
                    'Date: ${item.date}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Spacer(), // Add space between date and time
                  Text(
                    'Time: ${item.time}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.green, // Set the value text color to green
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            color: primary_color, // Top 20% of the screen is green
            child: Column(
              children: [
                SizedBox(height: 20), // Add space between the top and the text (name
                Text('My Orders', style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold)),
                SizedBox(height: 30),
                TabBar(
                  controller: _tabController,
                  labelColor: Colors.black, // Change the color of the selected tab text
                  tabs: [
                    Tab(
                      child: Text(
                        'Ongoing',
                        style: TextStyle(color: Colors.white), // Change the color of the unselected tab text
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Completed',
                        style: TextStyle(color: Colors.white), // Change the color of the unselected tab text
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Cancelled',
                        style: TextStyle(color: Colors.white), // Change the color of the unselected tab text
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ListView(
                  children: _tabsContent[0],
                ),
                ListView(
                  children: _tabsContent[1],
                ),
                ListView(
                  children: _tabsContent[2],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TabData {
  final String collectionId;
  final String totalWeight;
  final String approxPrice;
  final String oTP;
  final String date;
  final String time;
  final String itemCountsString;
  final String address; // Add address field

  TabData({
    required this.collectionId,
    required this.totalWeight,
    required this.approxPrice,
    required this.oTP,
    required this.date,
    required this.time,
    required this.itemCountsString,
    required this.address, // Include address in the constructor
  });
}

class OrderDetailsPage extends StatelessWidget {
  final TabData order;
  final String itemCountsString;
  final double ratePerKg;

  OrderDetailsPage({
    required this.order,
    required this.itemCountsString,
    required this.ratePerKg,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text('Collection ID: ${order.collectionId}'),
                ),
                SizedBox(height: 20),
                SelectedItemsWidget(
                  itemCountsString: itemCountsString,
                  ratePerKg: ratePerKg,
                ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Address',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
  'Address: ${order.address}',
  style: TextStyle(
    fontSize: 16,
  ),
),

                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text('Date: ${order.date}', style: TextStyle(fontWeight: FontWeight.bold)),
                        Spacer(), // Add space between total weight and total price
                        Text('Time: ${order.time}', style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text('OTP: ${order.oTP}'),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/profile_pic.png'), // Add the path to the profile picture
                    ),
                    SizedBox(width: 10), // Add space between profile picture and name
                    Text('John Doe', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        // Handle call agent
                        // This function will be called when the call icon is tapped
                      },
                      child: Icon(Icons.call, size: 50, color: Colors.green),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Handle cancel pickup
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
                child: Text(
                  'Cancel Pickup',
                  style: TextStyle(fontSize: 21),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
}

class SelectedItemsWidget extends StatelessWidget {
  final String itemCountsString;
  final double ratePerKg;

  SelectedItemsWidget({
    required this.itemCountsString,
    required this.ratePerKg,
  });

  @override
  Widget build(BuildContext context) {
    // Define the map of categories and items
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

    // Split the itemCountsString by '|'
    List<String> itemCountsList = itemCountsString.split('|');
    List<Widget> selectedItemsWidgets = [];
    double totalCost = 0;

    int categoryIndex = 0;
    // Iterate through the _itemLists map
    _itemLists.forEach((category, items) {
      String categoryCounts = itemCountsList[categoryIndex];
      for (int i = 0; i < items.length; i++) {
        // Get the count of the item from categoryCounts
        int count = int.parse(categoryCounts[i]);
        if (count > 0) {
          // If count is greater than zero, add the item to selectedItemsWidgets list
          double totalPrice = count * ratePerKg;
          totalCost += totalPrice;
          selectedItemsWidgets.add(
            buildItemRow(items[i], count, totalPrice),
          );
        }
      }
      categoryIndex++;
    });

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
        SizedBox(height: 16),
        // Display the selected items
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: selectedItemsWidgets,
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
              'Rs ${totalCost.toStringAsFixed(2)}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildItemRow(String itemName, int count, double totalPrice) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$itemName: $count KG'),
          Text('Rs ${totalPrice.toStringAsFixed(2)}'),
        ],
      ),
    );
  }
}


class Item {
  final String name;
  final double weight;

  Item({required this.name, required this.weight});
}
