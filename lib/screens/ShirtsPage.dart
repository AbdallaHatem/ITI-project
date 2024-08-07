// lib/screens/shirts_page.dart
import 'package:flutter/material.dart';
import 'package:shopping_app/components/item_container.dart';
import 'package:shopping_app/components/list.dart';
import 'package:shopping_app/database/database_handler.dart';
import 'package:shopping_app/login/shared_pref.dart';
import 'package:shopping_app/screens/product_details.dart';

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
        backgroundColor: Color(0xffDB3022),
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
                    return ItemContainer(
                      name: shirts[index]["name"],
                      imagePath: shirts[index]["image"],
                      price: "${shirts[index]["price"]} EGP",
                      isDarkMode: isDarkMode,
                      onTap: () {
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
