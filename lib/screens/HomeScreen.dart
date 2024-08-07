// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:shopping_app/components/Categorylist.dart';
import 'package:shopping_app/components/item_container.dart';
import 'package:shopping_app/components/navbar.dart';
import 'package:shopping_app/database/database_handler.dart';
import 'package:shopping_app/login/shared_pref.dart';
import 'package:shopping_app/screens/product_details.dart';
import 'package:shopping_app/components/list.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    DataBaseHandler db = DataBaseHandler();
    int? id = sharedPref.id;

    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(),
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 20, left: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Search
                Padding(
                  padding: EdgeInsets.only(right: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 1.3,
                        decoration: BoxDecoration(
                          color: Color(0xFFE0E0E0),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            label: Text(
                              "find your product",
                              style: TextStyle(fontSize: 20),
                            ),
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.search,
                              size: 30,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isDarkMode = !isDarkMode;
                          });
                        },
                        child: Container(
                          child: Icon(
                            Icons.dark_mode,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                // Big sale
                Container(
                  margin: EdgeInsets.only(right: 25, top: 20),
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset(
                          'assets/images/fashion.png',
                          fit: BoxFit.cover,
                          height: 500,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                      Positioned(
                        bottom: 200,
                        left: 50,
                        child: Text(
                          'Big Sales 30%',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 100,
                        left: 130,
                        child: ElevatedButton(
                          onPressed: () {
                            // Add your action for the button here
                          },
                          child: Text('Check'),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              //categorie list
                CategoryList(isDarkMode: isDarkMode), 

                // Items container
                Column(
                  children: List.generate((products.length / 4).ceil(), (rowIndex) {
                    int startIndex = rowIndex * 4;
                    int endIndex = startIndex + 4;
                    List rowItems = products.sublist(
                      startIndex,
                      endIndex > products.length ? products.length : endIndex,
                    );

                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(rowItems.length, (index) {
                          return ItemContainer(
                            name: rowItems[index]["name"],
                            imagePath: rowItems[index]["image"],
                            price: "${rowItems[index]["price"]} EGP",
                            isDarkMode: isDarkMode,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailsPage(
                                    name: rowItems[index]["name"],
                                    description: rowItems[index]["desc"],
                                    imagePath: rowItems[index]["image"],
                                    price: "${rowItems[index]["price"]} EGP",
                                    userId: id!,
                                    productId: rowItems[index]["id"],
                                  ),
                                ),
                              );
                            },
                          );
                        }),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
