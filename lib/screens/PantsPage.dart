import 'package:flutter/material.dart';
import 'package:shopping_app/components/navbar.dart';
import 'package:shopping_app/database/database_handler.dart';
import 'package:shopping_app/screens/product_details.dart';
import 'package:shopping_app/shared_pref.dart';
import '../components/list.dart';

class PantsPage extends StatefulWidget {
  PantsPage({Key? key}) : super(key: key);

  @override
  _PantsPageState createState() => _PantsPageState();
}

class _PantsPageState extends State<PantsPage> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    DataBaseHandler db = DataBaseHandler();
    int? id = sharedPref.id;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Pants Page'),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 20, left: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // List of pants
                GridView.count(
                  childAspectRatio: .4,
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  physics: NeverScrollableScrollPhysics(),
                  children: List.generate(pants.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        // Navigate to details page here
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailsPage(
                              name: pants[index]["name"],
                              description: pants[index]["desc"],
                              imagePath: pants[index]["image"],
                              price: "${pants[index]["price"]} EGP",
                              userId: id!,
                              productId: pants[index]["id"],
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
                                pants[index]["image"],
                                width: MediaQuery.of(context).size.width,
                                height: 250,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              pants[index]["name"],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "${pants[index]["price"]} EGP",
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

List<Map<String, dynamic>> pants = [
  {
    "id": 2,
    "typeID": 3,
    "name": "pants",
    "desc": "wide Leg pants with side stripes",
    "price": 950,
    "image": "assets/images/pans1.jpg",
  },
  {
    "id": 7,
    "typeID": 3,
    "name": "pants",
    "desc": "Slim-fit trousers",
    "price": 1000,
    "image": "assets/images/pans2.jpg",
  },
  {
    "id": 10,
    "typeID": 3,
    "name": "pants",
    "desc": "Cargo pants with multiple pockets",
    "price": 1150,
    "image": "assets/images/pans3.jpg",
  },
  {
    "id": 11,
    "typeID": 3,
    "name": "pants",
    "desc": "Skinny jeans",
    "price": 1000,
    "image": "assets/images/pans4.jpg",
  },
  {
    "id": 14,
    "typeID": 3,
    "name": "pants",
    "desc": "Chinos",
    "price": 900,
    "image": "assets/images/pans5.jpg",
  },
  {
    "id": 16,
    "typeID": 3,
    "name": "pants",
    "desc": "Cropped trousers",
    "price": 1100,
    "image": "assets/images/pans6.jpg",
  },
  {
    "id": 18,
    "typeID": 3,
    "name": "pants",
    "desc": "Sweatpants",
    "price": 920,
    "image": "assets/images/pans7.jpg",
  },
];
