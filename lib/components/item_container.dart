// lib/item_container.dart
import 'package:flutter/material.dart';

class ItemContainer extends StatelessWidget {
  final String name;
  final String imagePath;
  final String price;
  final bool isDarkMode;
  final VoidCallback onTap;

  const ItemContainer({
    required this.name,
    required this.imagePath,
    required this.price,
    required this.isDarkMode,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        color: isDarkMode ? Colors.grey[800] : Colors.white,
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              child: Image.asset(
                imagePath,
                width: 150,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            Text(
              name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 5),
            Text(
              price,
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
