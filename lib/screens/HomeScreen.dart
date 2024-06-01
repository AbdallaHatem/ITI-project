import 'package:flutter/material.dart';
import 'package:shopping_app/components/navbar.dart';
import 'package:shopping_app/database/database_handler.dart';
import 'package:shopping_app/screens/JacketsPage.dart';
import 'package:shopping_app/screens/product_details.dart';
import 'package:shopping_app/shared_pref.dart';
import '../components/list.dart';
import 'BagsPage.dart';
import 'PantsPage.dart';
import 'ShirtsPage.dart';

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
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      'assets/images/letters-label-wooden-background.jpg',
                      width: MediaQuery.of(context).size.width / 1.1,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),


                // List of categories
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (int i = 0; i < catlist.length; i++)
                          GestureDetector(
                            onTap: () {
                              // Navigate to different pages based on index
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
                ),


                // Items container
                GridView.count(
                  childAspectRatio: .4,
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  physics: NeverScrollableScrollPhysics(),
                  children: List.generate(products.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        // Navigate to details page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailsPage(
                              name: products[index]["name"],
                              description: products[index]["desc"],
                              imagePath: products[index]["image"],
                              price: "${products[index]["price"]} EGP",
                              userId: id!,
                              productId: products[index]["id"],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: 200,
                        color: isDarkMode ? Colors.grey[800] : Colors.white,
                        margin: EdgeInsets.only(top: 10, left: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              child: Image.asset(
                                products[index]["image"],
                                width: MediaQuery.of(context).size.width,
                                height: 250,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              products[index]["name"],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "${products[index]["price"]} EGP",
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