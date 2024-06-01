import 'package:flutter/material.dart';
import 'package:shopping_app/components/navbar.dart';
import 'package:shopping_app/database/database_handler.dart';
import 'package:shopping_app/screens/product_details.dart';
import 'package:shopping_app/shared_pref.dart';
import '../components/list.dart';

class BagsPage extends StatefulWidget {
  BagsPage({Key? key}) : super(key: key);

  @override
  _BagsPageState createState() => _BagsPageState();
}

class _BagsPageState extends State<BagsPage> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    DataBaseHandler db = DataBaseHandler();
    int? id = sharedPref.id;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Bags Page'),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 20, left: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // List of bags
                GridView.count(
                  childAspectRatio: .4,
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  physics: NeverScrollableScrollPhysics(),
                  children: List.generate(bags.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        // Navigate to details page here
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailsPage(
                              name: bags[index]["name"],
                              description: bags[index]["desc"],
                              imagePath: bags[index]["image"],
                              price: "${bags[index]["price"]} EGP",
                              userId: id!,
                              productId: bags[index]["id"], // Ensure you pass the product ID
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
                                bags[index]["image"],
                                width: MediaQuery.of(context).size.width,
                                height: 250,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              bags[index]["name"],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "${bags[index]["price"]} EGP",
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

List<Map<String, dynamic>> bags = [
  {
    "id": 24,
    "typeID": 4,
    "name": "Bag",
    "desc": "Canvas tote bag",
    "price": 800,
    "image": "assets/images/bag1.jpg",
  },
  {
    "id": 26,
    "typeID": 4,
    "name": "Bag",
    "desc": "Leather shoulder bag",
    "price": 950,
    "image": "assets/images/bag2.png",
  },
  {
    "id": 28,
    "typeID": 4,
    "name": "Bag",
    "desc": "Crossbody bag",
    "price": 780,
    "image": "assets/images/bag3.jpeg",
  },
  {
    "id": 29,
    "typeID": 4,
    "name": "Bag",
    "desc": "Nylon backpack",
    "price": 950,
    "image": "assets/images/bag4.jpeg",
  },
];
