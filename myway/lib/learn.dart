import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:junkee/global.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary_color,
        title: Text('Learn', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                color: primary_color,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 16),
                      Container(
  width: 500, // Set the desired width
  child: TextField(
    onChanged: (value) {
      // Call your search function here
      // You can perform search operations as the user types
    },
    decoration: InputDecoration(
      fillColor: Colors.white,
      filled: true,
      hintText: 'Search',
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      prefixIcon: Icon(Icons.search),
    ),
  ),
),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.only(left: 16.0), // Adjust the left padding as needed
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'New',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    HorizontalListView(
                      children: [
                        PreviewContainer(
                          image: AssetImage("assets/Screenshot 2024-02-15 162238.png"),
                          title: 'Title 1',
                          views: '1.5K views', description: 'In the above code, the GestureDetector wraps the container and triggers navigation to the ImageDetailPage when tapped. The ImageDetailPage receives the image and description data as constructor arguments and displays them accordingly.Now, you need to make sure you pass the correct image and description data to each PreviewContainer widget when you create them.',
                        ),
                        PreviewContainer(
                          image: NetworkImage('https://example.com/image2.jpg'),
                          title: 'Title 2',
                          views: '2K views', description: '',
                        ),
                        PreviewContainer(
                          image: NetworkImage('https://example.com/image3.jpg'),
                          title: 'Title 3',
                          views: '3.2K views', description: '',
                        ),
                      ],
                    ),
                    SizedBox(height: 32),
                    Text(
                      'Popular',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    HorizontalListView(
                      children: [
                        PreviewContainer(
                          image: AssetImage('assets/popular_image1.jpg'),
                          title: 'Popular Title 1',
                          views: '5K views', description: 'fsdfd',
                        ),
                        PreviewContainer(
                          image: AssetImage('assets/popular_image2.jpg'),
                          title: 'Popular Title 2',
                          views: '3.8K views', description: '',
                        ),
                        PreviewContainer(
                          image: AssetImage('assets/popular_image3.jpg'),
                          title: 'Popular Title 3',
                          views: '2.7K views', description: '',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }
}


class HorizontalListView extends StatelessWidget {
  final List<Widget> children;

  HorizontalListView({required this.children});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: children,
      ),
    );
  }
}

class PreviewContainer extends StatelessWidget {
  final ImageProvider image;
  final String title;
  final String views;
  final String description;

  PreviewContainer({
    required this.image,
    required this.title,
    required this.views,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ImageDetailPage(
              image: image,
              description: description, title: title, views: views,
            ),
          ),
        );
      },
      child: Container(
        width: 150,
        height: 200,
        margin: EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey, width: 2),
          image: DecorationImage(
            image: image,
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              width: double.infinity,
              color: Colors.black.withOpacity(0.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    views,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class ImageDetailPage extends StatelessWidget {
  final ImageProvider image;
  final String title;
  final String views;
  final String description;

  ImageDetailPage({
    required this.image,
    required this.title,
    required this.views,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Image container taking 30% of screen height
          Expanded(
            flex: 3, // 30% of the screen height
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image(
                    image: image,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
          // Title, Views, and Description container taking 70% of screen height
          Expanded(
            flex: 5, // 70% of the screen height
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    views,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Upload button container
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () async {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyUploadPage(),
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
                child: Text(
                  'Upload',
                  style: TextStyle(fontSize: 21),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MyUploadPage extends StatefulWidget {
  @override
  _MyUploadPageState createState() => _MyUploadPageState();
}

class _MyUploadPageState extends State<MyUploadPage> {
  final ImagePicker _imagePicker = ImagePicker();
  List<XFile>? _selectedPhotos;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField(context, _titleController, 'Title'),
            SizedBox(height: 16.0),
            _buildTextField(context, _descriptionController, 'Description'),
            SizedBox(height: 16.0),
            _buildPhotoPicker(context),
            SizedBox(height: 16.0),
            //the upload button needs to be at bottom of screen
            ElevatedButton(
  onPressed: () async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MyPage(),
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
  child: Text(
    'Save',
    style: TextStyle(fontSize: 21),
  ),
),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(BuildContext context, TextEditingController controller, String hintText) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: hintText,
        border: OutlineInputBorder(),
      ),
    );
  }

Widget _buildPhotoPicker(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      GestureDetector(
        onTap: () async {
          List<XFile>? images = await _pickImages();
          setState(() {
            _selectedPhotos = images;
          });
        },
        child: Container(
          height: 150,
          width: double.infinity,

          decoration: BoxDecoration(
            border: Border.all(color: Colors.green, style: BorderStyle.solid, width: 2.0),
          ),
          padding: EdgeInsets.all(8.0),
          //align the below text to center of the container
          child: Center(
            child: Text('Tap to Pick Photos', style: TextStyle(color: Colors.grey)),
          ),
                  ),
      ),
      if (_selectedPhotos != null && _selectedPhotos!.isNotEmpty)
        _buildImagePreview(_selectedPhotos!),
    ],
  );
}


  Widget _buildImagePreview(List<XFile> images) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8),
        Text('Selected Photos:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: images.length,
            itemBuilder: (context, index) {
              return _buildImageItem(images[index].path);
            },
          ),
        ),
        SizedBox(height: 8),
      ],
    );
  }

  Widget _buildImageItem(String imagePath) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.file(
          File(imagePath),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Future<List<XFile>?> _pickImages() async {
    try {
      return await _imagePicker.pickMultiImage();
    } catch (e) {
      print('Error picking images: $e');
      return null;
    }
  }

  void _addPost() async {
    // Fetch necessary data and perform upload logic
    // For now, we'll print the data
    String title = _titleController.text;
    String description = _descriptionController.text;
    List<String> photoPaths = _selectedPhotos?.map((file) => file.path).toList() ?? [];

    print('Title: $title');
    print('Description: $description');
    print('Photos: $photoPaths');
  }
}
