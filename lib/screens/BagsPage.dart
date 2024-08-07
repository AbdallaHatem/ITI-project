// lib/screens/bags_page.dart
import 'package:flutter/material.dart';
import 'package:shopping_app/components/item_container.dart';
import 'package:shopping_app/components/list.dart';
import 'package:shopping_app/database/database_handler.dart';
import 'package:shopping_app/login/shared_pref.dart';
import 'package:shopping_app/screens/product_details.dart';

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
        backgroundColor: Color(0xffDB3022),
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
                //item container
                    return ItemContainer(
                      name: bags[index]["name"],
                      imagePath: bags[index]["image"],
                      price: "${bags[index]["price"]} EGP",
                      isDarkMode: isDarkMode,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailsPage(
                              name: bags[index]["name"],
                              description: bags[index]["desc"],
                              imagePath: bags[index]["image"],
                              price: "${bags[index]["price"]} EGP",
                              userId: id!,
                              productId: bags[index]["id"],
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
