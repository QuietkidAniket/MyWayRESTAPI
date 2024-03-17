import 'package:flutter/material.dart';
import 'package:junkee/dailyschedulepage.dart';
import 'package:junkee/global.dart';
import 'package:junkee/orders.dart';
import 'package:junkee/pricechart.dart';
import 'package:junkee/process_timeline.dart';

class recyclePage extends StatefulWidget {
// Initialize tasks in the constructor

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<recyclePage> {
  
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: CustomPaint(
        size: Size(screenWidth, screenHeight),
        painter: InclinedBorderPainter(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/mywayicon.png'), // Provide your image path
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Good morning',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        Text(
                          'Daniel',
                          style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    //add an notification icon here
                    Spacer(),
                    IconButton(icon: Icon(Icons.notifications_none_outlined, color: Colors.white, size: 30), onPressed: () {})
                  ],
                ),
                SizedBox(height: 16),
                GestureDetector(
  onTap: () {
    // Navigate to the page for viewing, editing, and adding to the daily schedule
    Navigator.push(context, MaterialPageRoute(builder: (context) => DailySchedulePage()));
  },
  child: Container(
    width: double.infinity,
    height: 200,
    padding: EdgeInsets.all(16),
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
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Current Activity:', // Change to display the current activity
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Add functionality here to view, edit, and add to the daily schedule
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DailySchedulePage()));
                },
                child: Text('View Schedule'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(width: 16),
        Container(
          width: 180,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ],
    ),
  ),
),
                SizedBox(height: 26),
                Row(
  children: [
    Expanded(
      child: GestureDetector(
        onTap: () {
          // Navigate to the page for booking a pickup
          Navigator.push(context, MaterialPageRoute(builder: (context) => YourPage(selectedGridItem: 'Paper'),));
        },
        child: Container(
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.only(right: 8), // Adjust margin as needed
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
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.local_shipping, // Icon for booking a pickup
                  color: primary_color,
                  size: 30,
                ),
                SizedBox(height: 8), // Spacer between icon and text
                Text(
                  'Book a Pickup',
                  style: TextStyle(
                    color: primary_color,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
    Expanded(
      child: GestureDetector(
        onTap: () {
          // Navigate to the page for finding the nearest shop
          Navigator.push(context, MaterialPageRoute(builder: (context) => PriceChartPage()));
        },
        child: Container(
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.only(left: 8), // Adjust margin as needed
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
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.store, // Icon for finding the nearest shop
                  color: primary_color,
                  size: 30,
                ),
                SizedBox(height: 8), // Spacer between icon and text
                Text(
                  'Price Chart',
                  style: TextStyle(
                    color: primary_color,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  ],
),


                SizedBox(height: 16),
                Text("What We Collect", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                buildGridView(),
                Text('How It Works', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                buildSteps(),
                Text('Reviews', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ReviewWidget(), // Here is the reviews section
              ],
            ),
          ),
        ),
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
        crossAxisCount: 4,
        children: [
          buildItem('Paper', Icons.pages),
          buildItem('Clothes', Icons.local_laundry_service),
          buildItem('Plastic', Icons.face),
          buildItem('E-waste', Icons.electrical_services),
          buildItem('Metal', Icons.precision_manufacturing),
          buildItem('Glass', Icons.earbuds),
          buildItem('Motor', Icons.pages),
          buildItem('Other', Icons.pages),
        ],
      ),
    );
  }

  Widget buildItem(String title, IconData icon) {
  return GestureDetector(
    onTap: () {
      // Navigate to YourPage with the selected grid item
      Navigator.push(context, MaterialPageRoute(builder: (context) => YourPage(selectedGridItem: title)));
    },
    child: Card(
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
        buildStep('Select your items', 'assets/mywayicon.png', 'Select the items you want to recycle'),
        buildStep('Make a schedule', 'assets/mywayicon.png', 'Select the date and time for pickup'),
        buildStep('We will collect it', 'assets/mywayicon.png',  'We will come to your doorstep to collect the items'),
      ],
    );
  }

Widget buildStep(String title, String image, String additionalText) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
    child: Container(
      //make backgorund color of contianer white
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListTile(
        leading: Image.asset(image, width: 24),
        title: Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
class ReviewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 175, // Adjust height as per your requirement
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          ReviewTile(
            profileImage: 'assets/profile1.png',
            name: 'John Doe',
            stars: 4,
            review: 'Great service!',
          ),
          ReviewTile(
            profileImage: 'assets/profile2.png',
            name: 'Jane Smith',
            stars: 5,
            review: 'Very satisfied with the recycling process.',
          ),
          // Add more ReviewTiles as needed
        ],
      ),
    );
  }
}

class ReviewTile extends StatelessWidget {
  final String profileImage;
  final String name;
  final int stars;
  final String review;

  ReviewTile({
    required this.profileImage,
    required this.name,
    required this.stars,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300, // Adjust as needed
      margin: EdgeInsets.only(right: 10), // Adjust spacing between tiles
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(profileImage),
                  ),
                  SizedBox(width: 18), // Add some horizontal space
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: List.generate(
                          stars,
                          (index) => Icon(
                            Icons.star,
                            color: Color.fromARGB(255, 239, 162, 28),
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                review,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
