// lib/screens/pants_page.dart
import 'package:flutter/material.dart';
import 'package:shopping_app/components/item_container.dart';
import 'package:shopping_app/components/list.dart';
import 'package:shopping_app/database/database_handler.dart';
import 'package:shopping_app/login/shared_pref.dart';
import 'package:shopping_app/screens/product_details.dart';

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
        backgroundColor: Color(0xffDB3022),
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
                    return ItemContainer(
                      name: pants[index]["name"],
                      imagePath: pants[index]["image"],
                      price: "${pants[index]["price"]} EGP",
                      isDarkMode: isDarkMode,
                      onTap: () {
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
