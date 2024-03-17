import 'package:flutter/material.dart';
import 'package:junkee/learn.dart';
import 'package:junkee/orders.dart';
import 'package:junkee/profile.dart';
import 'package:junkee/recycle.dart';

class HomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
    int _selectedIndex = 0;
  @override
  void _onItemTapped(int index){
    _selectedIndex = index;
    setState(() {
      
    });
  }
  Widget build(BuildContext context) {
    Color yomama = Colors.grey;
    return Scaffold(
      body: _selectedIndex == 0
            ? recyclePage()
            : _selectedIndex == 1
                ? MyPage()
                : _selectedIndex == 2
                    ? OrdersPage()
                    : ProfilePage(),
      bottomNavigationBar:  BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        fixedColor: Colors.black,
        unselectedItemColor: yomama,
      currentIndex: _selectedIndex,
      onTap: (index) {_onItemTapped(index);},
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.note),
          label: 'Applications',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month_rounded),
          label: 'Calendar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: 'Alerts',
        ),
      ],
    )
    );
  }

  Widget buildSection(String title, String image) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          image.isNotEmpty
              ? Image.asset(image, width: 48)
              : SizedBox(width: 48),
          SizedBox(width: 16),
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget buildButtonRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              child: Text('Book a Pickup'),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              child: Text('Nearest Shop'),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGridView() {
    return Container(
      height: 250,
      child: GridView.count(
        crossAxisCount: 2,
        children: [
          buildItem('Paper', Icons.pages),
          buildItem('Clothes', Icons.local_laundry_service),
          buildItem('Plastic', Icons.face),
          buildItem('E-waste', Icons.electrical_services),
          buildItem('Metal', Icons.precision_manufacturing),
          buildItem('Glass', Icons.earbuds),
        ],
      ),
    );
  }

  Widget buildItem(String title, IconData icon) {
    return Card(
      child: InkWell(
        splashColor: Colors.green.withAlpha(30),
        onTap: () {},
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 48),
              SizedBox(height: 8),
              Text(title, style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSteps() {
    return Column(
      children: [
        buildStep('Select your items', 'assets/Screenshot 2024-02-15 162238.png', 'Select the items you want to recycle'),
        buildStep('Make a schedule', 'assets/Screenshot 2024-02-15 162302.png', 'Select the date and time for pickup'),
        buildStep('We will collect it', 'assets/Screenshot 2024-02-15 162319.png',  'We will come to your doorstep to collect the items'),
      ],
    );
  }

Widget buildStep(String title, String image, String additionalText) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListTile(
        leading: Image.asset(image, width: 24),
        title: Text(
          title,
          style: TextStyle(fontSize: 16),
        ),
        subtitle: Text(
          additionalText,
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ),
    ),
  );
}


  /*Widget buildReview() {
    return Container(
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return buildReviewItem();
        },
      ),
    );
  }

  Widget buildReviewItem() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.asset(
              'assets/images/profile.png',
              width: 64,
              height: 64,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 8),
          Text('Rajesh Gupta'),
          SizedBox(height: 4),
          Text('Kolkata'),
          SizedBox(height: 4),
          Text(
            '⭐⭐⭐⭐⭐',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }*/
}