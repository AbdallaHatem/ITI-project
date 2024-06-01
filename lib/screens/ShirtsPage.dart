import 'package:flutter/material.dart';
import 'package:shopping_app/database/database_handler.dart';
import 'package:shopping_app/screens/product_details.dart';
import 'package:shopping_app/shared_pref.dart';

class ShirtsPage extends StatefulWidget {
  ShirtsPage({Key? key}) : super(key: key);

  @override
  _ShirtsPageState createState() => _ShirtsPageState();
}

class _ShirtsPageState extends State<ShirtsPage> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    DataBaseHandler db = DataBaseHandler();
    int? id = sharedPref.id;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Shirts Page'),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 20, left: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [



                // List of shirts
                GridView.count(
                  childAspectRatio: .4,
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  physics: NeverScrollableScrollPhysics(),
                  children: List.generate(shirts.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        // Navigate to details_page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailsPage(
                              name: shirts[index]["name"],
                              description: shirts[index]["desc"],
                              imagePath: shirts[index]["image"],
                              price: "${shirts[index]["price"]} EGP",
                              userId: id!,
                              productId: shirts[index]["id"],
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
                                shirts[index]["image"],
                                width: MediaQuery.of(context).size.width,
                                height: 250,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              shirts[index]["name"],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "${shirts[index]["price"]} EGP",
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

List<Map<String, dynamic>> shirts = [
{
  "id": 1,
  "typeID": 2,
  "name": "Shirt",
  "desc": "girls shirt with floral design",
  "price": 1200,
  "image": "assets/images/shirt1.jpg",
},
  {
    "id": 4,
    "typeID": 2,
    "name": "Shirt",
    "desc": "Cotton shirt with checkered pattern",
    "price": 1100,
    "image": "assets/images/shirt2.jpg",
  },
  {
    "id": 5,
    "typeID": 2,
    "name": "Shirt",
    "desc": "Casual shirt",
    "price": 850,
    "image": "assets/images/image5.jpeg",
  },
  {
    "id": 8,
    "typeID": 2,
    "name": "Shirt",
    "desc": "Striped shirt",
    "price": 950,
    "image": "assets/images/shirt3.jpg",
},
{
  "id": 9,
  "typeID": 2,
  "name": "Shirt",
  "desc": "Cotton shirt",
  "price": 1200,
  "image": "assets/images/shirt4.jpg",
},
{
  "id": 12,
  "typeID": 2,
  "name": "Shirt",
  "desc": "Floral print shirt",
  "price": 1200,
  "image": "assets/images/shirt5.jpg",
},
{
  "id": 15,
  "typeID": 2,
  "name": "Shirt",
  "desc": "V-neck t-shirt",
  "price": 850,
  "image": "assets/images/shirt6.jpg",
},
{
  "id": 19,
  "typeID": 2,
  "name": "Shirt",
  "desc": "Long-sleeve shirt",
  "price": 800,
  "image": "assets/images/shirt7.jpg",
},
{
  "id": 20,
  "typeID": 2,
  "name": "Shirt",
  "desc": "Denim shirt",
  "price": 1150,
  "image": "assets/images/shirt8.jpg",
},
  {
    "id": 23,
    "typeID": 2,
    "name": "Shirt",
    "desc": "Button-up shirt",
    "price": 950,
    "image": "assets/images/shirt9.jpg",
  },


];