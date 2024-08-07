// lib/screens/jackets_page.dart
import 'package:flutter/material.dart';
import 'package:shopping_app/components/item_container.dart';
import 'package:shopping_app/components/list.dart';
import 'package:shopping_app/database/database_handler.dart';
import 'package:shopping_app/screens/product_details.dart';
import 'package:shopping_app/login/shared_pref.dart';

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
        backgroundColor: Color(0xffDB3022),
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
                    return ItemContainer(
                      name: jackets[index]["name"],
                      imagePath: jackets[index]["image"],
                      price: "${jackets[index]["price"]} EGP",
                      isDarkMode: isDarkMode,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailsPage(
                              name: jackets[index]["name"],
                              description: jackets[index]["desc"],
                              imagePath: jackets[index]["image"],
                              price: "${jackets[index]["price"]} EGP",
                              userId: id!,
                              productId: jackets[index]["id"],
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
