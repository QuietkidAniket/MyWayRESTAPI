import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:junkee/global.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary_color,
        centerTitle: true,
        title: Text('Profile', style: TextStyle(color: Colors.white),),

      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: primary_color, // Use the primary color for the drawer header
              ),
              child: Center(
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            _buildListTile(context, 'Points and Rewards', PointsAndRewardsPage()),
            Divider(),
            _buildListTile(context, 'Notification', NotificationPage()),
            Divider(),
            _buildListTile(context, 'Invite', InvitePage()),
            Divider(),
            _buildListTile(context, 'Settings', SettingsPage()),
            Divider(),
            _buildListTile(context, 'About us', AboutUsPage()),
            Divider(),
            _buildListTile(context, 'Help and Support', HelpAndSupportPage()),
            Divider(),
            _buildListTile(context, 'Privacy & Policies', PrivacyAndPoliciesPage()),
            Divider(),
            _buildListTile(context, 'Sign Out', SignOutPage()),
            Divider(),
          ],
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                color: primary_color, // Top 20% of the screen is green
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 30), // Adjust the height for spacing
                      Center(
                        child: Text(
                          'John Doe', // Replace with the actual name
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 20), // Add spacing between the name and the container
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20), // Adjust horizontal padding
                        child: Container(
                          padding: EdgeInsets.all(20), // Adjust padding as needed
                          decoration: BoxDecoration(
                            color: Colors.grey[200], // Example background color
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '60 KGS',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'Of Waste has been recycled',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 20), // Add spacing between the text and the image
                            ],
                          ),
                        ),
                      ),
                      
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 10,
            left: MediaQuery.of(context).size.width / 2 - 50, // Center horizontally
            child: Container(
              width: 100,
              height: 140, // Adjusted to accommodate text above the CircleAvatar
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/mywayicon.png'), // Example image asset
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

 


  Widget _buildListTile(BuildContext context, String title, Widget page) {
    return GestureDetector(
      onTap: () {
        // Navigate to the specified page when the tile is tapped
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: ListTile(
        title: Text(title),
        trailing: Icon(Icons.arrow_forward_ios),
        leading: Icon(Icons.access_alarm),
      ),
    );
  }
}

// Define separate pages for each tile
class PointsAndRewardsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Points and Rewards'),
      ),
      body: Center(
        child: Text('This is the Points and Rewards Page'),
      ),
    );
  }
}

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification'),
      ),
      body: Center(
        child: Text('This is the Notification Page'),
      ),
    );
  }
}

class InvitePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invite'),
      ),
      body: Center(
        child: Text('This is the Invite Page'),
      ),
    );
  }
}

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // The current language for the page
  String language = "English";

  // Method to display the page
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
        child:
      Column(
        children: [
          Divider(),
          ListTile(
            title: Text("My Address"),
          ),
          Divider(),
          ListTile(
            title: Text("Payment"),
          ),
          Divider(),
          ListTile(
            title: Text("Language: $language"),
          ),
          Divider(),
          ListTile(
            title: Text("Rate Us"),
          ),
          Divider(),
          ListTile(
            title: Text("Send Feedback"),
          ),
          Divider(),
          ListTile(
            title: Text("Settings"),
          ),
          Divider(),
          ListTile(
            title: Text("Current language: $language"),
          ),
          Divider(),
        ],
      ),
      ),
    );
  }

  // Method to change the language for the page
  void changeLanguage(String newLanguage) {
    if (newLanguage == "English" || newLanguage == "Spanish") {
      setState(() {
        language = newLanguage;
      });
    }
  }
}


class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: Center(
        child: Text('This is the About Us Page'),
      ),
    );
  }
}

class HelpAndSupportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help and Support'),
      ),
      body: Center(
        child: Text('This is the Help and Support Page'),
      ),
    );
  }
}

class PrivacyAndPoliciesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy & Policies'),
      ),
      body: Center(
        child: Text('This is the Privacy & Policies Page'),
      ),
    );
  }
}

class SignOutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Out'),
      ),
      body: Center(
        child: Text('This is the Sign Out Page'),
      ),
    );
  }
}

class Contribution extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Contribution'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Expanded(
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      value: 6,
                      title: 'Plastic',
                      color: Colors.blue,
                      radius: 100,
                      
                    ),
                    PieChartSectionData(
                      value: 9,
                      title: 'Clothes',
                      color: Colors.green,
                      radius: 100,
                    ),
                    PieChartSectionData(
                      value: 20,
                      title: 'Paper',
                      color: Colors.red,
                      radius: 100,
                    ),
                    PieChartSectionData(
                      value: 6,
                      title: 'Glass',
                      color: Colors.orange,
                      radius: 100,
                    ),
                    PieChartSectionData(
                      value: 30,
                      title: 'Scrap Metal',
                      color: Colors.purple,
                      radius: 100,
                    ),
                  ],
                  sectionsSpace: 0,
                  centerSpaceRadius: 80,
                  startDegreeOffset: 180,
                ),
              ),
            ),
            SizedBox(height: 16),
            //text in center
            Center(
              child: Column(
                children: [
                  Text(
              'You Saved',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'Contribution of your order to help the environment',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w100),
            ),
                ],
              ),
            ),
            SizedBox(height: 8),
            buildSavedRow('10', 'KGS'),
          ],
        ),
      ),
    );
  }

  Widget buildSavedRow(String amount, String unit) {
  return Container(
    height: 200,
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.water_drop, // Example icon
              color: Colors.blue, // Example color
            ),
            Icon(
              Icons.forest, // Example icon
              color: Colors.green, // Example color
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('50 Ltr water'), // Example text
            Text('10 Trees'), // Example text
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.wallet, // Example icon
              color: Colors.red, // Example color
            ),
            Icon(
              Icons.lightbulb, // Example icon
              color: Colors.orange, // Example color
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('20 Ltr oil'), // Example text
            Text('14 Kwh '), // Example text
          ],
        ),
      ],
    ),
  );
}

}