import 'package:flutter/material.dart';

class PriceChartPage extends StatefulWidget {
  @override
  _PriceChartPageState createState() => _PriceChartPageState();
}

class _PriceChartPageState extends State<PriceChartPage> {
  String _searchQuery = '';
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
    'Paper': ['Item 1', 'Item 2', 'Item 3'],
    'Clothes': ['Item 4', 'Item 5', 'Item 6'],
    'Plastic': ['Item 7', 'Item 8', 'Item 9'],
    'E-waste': ['Item 10', 'Item 11', 'Item 12'],
    'Metal': ['Item 13', 'Item 14', 'Item 15'],
    'Glass': ['Item 16', 'Item 17', 'Item 18'],
    'Motor': ['Item 19', 'Item 20', 'Item 21'],
    'Other': ['Item 22', 'Item 23', 'Item 24'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Price Chart'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          Container(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _gridItems.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedGridItem = _gridItems[index];
                    });
                  },
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Container(
                      width: 100, // Adjust the width as needed
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          _gridItems[index],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _itemLists[_selectedGridItem]?.length ?? 0,
              itemBuilder: (context, index) {
                // Filter items based on search query
                if (_searchQuery.isNotEmpty &&
                    !_itemLists[_selectedGridItem]![index]
                        .toLowerCase()
                        .contains(_searchQuery.toLowerCase())) {
                  return SizedBox.shrink(); // Hide the item if it doesn't match the search query
                }
                return ListTile(
                  title: Text(_itemLists[_selectedGridItem]?[index] ?? ''),
                  subtitle: Text('Rate: \$5/kg'),
                  leading: Icon(Icons.image),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: PriceChartPage(),
  ));
}
