// lib/components/category_list.dart
import 'package:flutter/material.dart';
import 'package:shopping_app/screens/BagsPage.dart';
import 'package:shopping_app/screens/JacketsPage.dart';
import 'package:shopping_app/screens/PantsPage.dart';
import 'package:shopping_app/screens/ShirtsPage.dart';
import 'package:shopping_app/components/list.dart';

class CategoryList extends StatelessWidget {
  final bool isDarkMode;

  const CategoryList({Key? key, required this.isDarkMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (int i = 0; i < catlist.length; i++)
              GestureDetector(
                onTap: () {
                  if (i == 1) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => JacketsPage()),
                    );
                  } else if (i == 2) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ShirtsPage()),
                    );
                  } else if (i == 3) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PantsPage()),
                    );
                  } else if (i == 4) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BagsPage()),
                    );
                  }
                },
                child: Container(
                  padding: EdgeInsets.only(
                      left: 18, right: 18, top: 10, bottom: 10),
                  margin: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: catlist[i] == "All"
                        ? Color(0xfff44336)
                        : Color(0xFFF7F8FA),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(catlist[i]),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
