import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:junkee/global.dart';
import 'package:junkee/schedule.dart';

class YourPage extends StatefulWidget {
  final String selectedGridItem;

  YourPage({required this.selectedGridItem});

  @override
  _YourPageState createState() => _YourPageState();
}


class _YourPageState extends State<YourPage> {
  int _processIndex = 1;
  String _selectedGridItem = '';

  @override
  void initState() {
    super.initState();
    _selectedGridItem = widget.selectedGridItem;
  }

  void _navigateToNextPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => schedulePage(itemCounts: {}),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pickup Request',
          style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold),
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
            top: MediaQuery.of(context).size.height * 0.13,
            left: 0,
            right: 0,
            bottom: 0,
            child: YourOtherContent(selectedGridItem: _selectedGridItem),
          ),
        ],
      ),
    );
  }
}

class YourOtherContent extends StatefulWidget {
  final String selectedGridItem;

  YourOtherContent({required this.selectedGridItem});

  @override
  _YourOtherContentState createState() => _YourOtherContentState();
}

class _YourOtherContentState extends State<YourOtherContent> {
   int _processIndex = 0;
  Map<String, Map<String, int>> _itemCounts = {
    'Paper': {'Newspaper': 0, 'Magazine': 0, 'Cardboard': 0, 'Books': 0, 'Office Paper': 0, 'Paper Bags': 0, 'Paper Cups': 0, 'Paper Plates': 0, 'Paper Towels': 0, 'Paper Napkins': 0, 'Paper Boxes': 0, 'Paper Wrappers': 0},
    'Clothes': {'Item 4': 0, 'Item 5': 0, 'Item 6': 0},
    'Plastic': {'Item 7': 0, 'Item 8': 0, 'Item 9': 0},
    'E-waste': {'Item 10': 0, 'Item 11': 0, 'Item 12': 0},
    'Metal': {'Item 13': 0, 'Item 14': 0, 'Item 15': 0},
    'Glass': {'Item 16': 0, 'Item 17': 0, 'Item 18': 0},
    'Motor': {'Item 19': 0, 'Item 20': 0, 'Item 21': 0},
    'Other': {'Item 22': 0, 'Item 23': 0, 'Item 24': 0},
  };

  void _navigateToNextPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => schedulePage(itemCounts: _itemCounts,),
      ),
    );
  }

  void _updateCount(String category, String item, int value) {
    setState(() {
      _itemCounts[category] ??= {}; // Ensure the category map is initialized
      _itemCounts[category]![item] = value;
    });
  }

  void displayItemCounts() {
    _itemCounts.forEach((category, items) {
      print('Category: $category');
      items.forEach((item, count) {
        print(' - $item: $count');
      });
    });
  }

  String _selectedGridItem = '';
  List<String> _gridItems = [
    'Paper',
    'Clothes',
    'Plastic',
    'E-waste',
    'Metal',
    'Glass',
    'Motor',
    'Other',
  ];

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
  @override
  void initState() {
    super.initState();
    // Set the selected grid item to the one passed from the parent widget
    _selectedGridItem = widget.selectedGridItem;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 135,
          width: 200,
          child: Column(
            children: [
              Divider(
                color: Colors.grey,
                thickness: 2,
              ),
              buildGridView(),
              Divider(
                color: Colors.grey,
                thickness: 2,
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: buildListTiles(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              _navigateToNextPage(); // Navigate to the next page
            },
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Color(0xff00926d)),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
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
        ),
      ],
    );
  }

  Widget buildGridView() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _gridItems
            .map(
              (item) => GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedGridItem = item;
                  });
                },
                child: Container(
                  height: 87,
                  width: 87,
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: _selectedGridItem == item
                        ? Colors.blue.withOpacity(0.3)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.image, size: 40, color: Colors.black),
                      SizedBox(height: 5),
                      Text(item),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget buildListTiles() {
    List<String> filteredList = _itemLists[_selectedGridItem] ?? [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: filteredList
          .map(
            (item) => Container(
              margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(
                    color: const Color.fromARGB(255, 228, 228, 228)),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ListTile(
                leading: Icon(Icons.image, size: 40, color: Colors.black),
                title: Text(item, style: TextStyle(color: Colors.black)),
                subtitle: Text('Rate: \$5/kg'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        int? count =
                            _itemCounts[_selectedGridItem]?[item] ?? 0;
                        if (count > 0) {
                          _updateCount(_selectedGridItem, item, count - 1);
                        }
                      },
                    ),
                    Text(
                      (_itemCounts[_selectedGridItem]?[item] ?? 0).toString(),
                      style: TextStyle(fontSize: 16),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        int? count =
                            _itemCounts[_selectedGridItem]?[item] ?? 0;
                        _updateCount(_selectedGridItem, item, count + 1);
                      },
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}