import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portfolio',

      home: PortfolioPage(),
    );
  }
}

class PortfolioPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Portfolio',
          style: TextStyle(
            fontFamily: 'Pacifico', // Use a custom font for the title
          ),
        ),
        backgroundColor: Colors.black54,
        centerTitle: true,// Custom app bar color
      ),
      body: ListView.builder(
        itemCount: portfolioItems.length,
        itemBuilder: (context, index) {
          final item = portfolioItems[index];
          return Card(
            margin: EdgeInsets.all(16.0),
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 200.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(item.imageUrl),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF333333), // Custom text color
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        item.description,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Color(0xFF666666), // Custom text color
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Implement navigation to the portfolio item details page
                      // You can use Navigator.push to navigate to a details page.
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black54, // Custom button color
                      onPrimary: Colors.white, // Custom text color for the button
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                    child: Text('Read More'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class PortfolioItem {
  final String title;
  final String description;
  final String imageUrl;

  PortfolioItem({
    required this.title,
    required this.description,
    required this.imageUrl,
  });
}

final List<PortfolioItem> portfolioItems = [
  PortfolioItem(
    title: 'Project 1',
    description: 'Description of Project 1. This project was...',
    imageUrl: 'https://assets.materialup.com/uploads/4554dde7-42b0-46e8-a8f6-0f112ff4ce34/preview.jpg', // Replace with your image URL
  ),
  PortfolioItem(
    title: 'Project 2',
    description: 'Description of Project 2. This project involved...',
    imageUrl: 'https://as2.ftcdn.net/v2/jpg/01/68/99/83/1000_F_168998328_4I7g2Bxt7o0GlpRxitgJQVfYoidZUv6P.jpg', // Replace with your image URL
  ),
  // Add more portfolio items with image URLs as needed
];