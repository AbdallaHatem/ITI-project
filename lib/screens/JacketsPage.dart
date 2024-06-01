import 'package:flutter/material.dart';
import 'package:shopping_app/components/navbar.dart';
import 'package:shopping_app/database/database_handler.dart';
import 'package:shopping_app/screens/product_details.dart';
import 'package:shopping_app/shared_pref.dart';
import '../components/list.dart';

class JacketsPage extends StatefulWidget {
  JacketsPage({Key? key}) : super(key: key);

  @override
  _JacketsPageState createState() => _JacketsPageState();
}

class _JacketsPageState extends State<JacketsPage> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    DataBaseHandler db = DataBaseHandler();
    int? id = sharedPref.id;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Jackets Page'),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 20, left: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // List of jackets
                GridView.count(
                  childAspectRatio: .4,
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  physics: NeverScrollableScrollPhysics(),
                  children: List.generate(jackets.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        // Navigate to details page here
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailsPage(
                              name: jackets[index]["name"],
                              description: jackets[index]["desc"],
                              imagePath: jackets[index]["image"],
                              price: "${jackets[index]["price"]} EGP",
                              userId: id!,
                              productId: jackets[index]["id"], // Ensure you pass the product ID
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
                                jackets[index]["image"],
                                width: MediaQuery.of(context).size.width,
                                height: 250,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              jackets[index]["name"],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "${jackets[index]["price"]} EGP",
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



List<Map<String, dynamic>> jackets = [
  {
    "id": 3,
    "typeID": 1,
    "name": "Jacket",
    "desc": "Black jacket for mens with zipper details",
    "price": 1250,
    "image": "assets/images/jacket1.jpg",
  },
  {
    "id": 6,
    "typeID": 1,
    "name": "Jacket",
    "desc": "Denim jacket with distressed look",
    "price": 1150,
    "image": "assets/images/jacket2.jpg",
  },
  {
    "id": 17,
    "typeID": 1,
    "name": "Jacket",
    "desc": "Hooded jacket",
    "price": 1280,
    "image": "assets/images/jacket3.jpg",
  },
  {
    "id": 25,
    "typeID": 1,
    "name": "Jacket",
    "desc": "Puffer jacket",
    "price": 1200,
    "image": "assets/images/jacket4.jpg",
  },
  {
    "id": 27,
    "typeID": 1,
    "name": "Jacket",
    "desc": "Bomber jacket",
    "price": 1200,
    "image": "assets/images/jacket5.jpeg",
  },
];
