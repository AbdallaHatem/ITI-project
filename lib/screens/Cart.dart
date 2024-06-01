import 'package:flutter/material.dart';
import 'package:shopping_app/database/database_handler.dart';
import 'package:shopping_app/screens/product_details.dart';
import 'package:shopping_app/shared_pref.dart';
import '../database/tables_classes.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  DataBaseHandler db = DataBaseHandler();
  List<int> ids = [];
  List<cart> mp = [];
  double totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    getCartItems();
  }

  Future<void> getCartItems() async {
    if (sharedPref.id != null) {
      mp = await db.getAllcart(sharedPref.id!);
      setState(() {
        ids = mp.map((cart) => cart.productID!).toList();
      });
      calculateTotalPrice();
    }
  }

  Future<void> calculateTotalPrice() async {
    List<product> products = await db.getProductsById(ids);
    double sum = 0.0;
    for (var product in products) {
      sum += product.price;
    }
    setState(() {
      totalPrice = sum;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Your Cart')),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: db.getProductsById(ids),
                builder: (BuildContext context, AsyncSnapshot<List<product>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          product currentProduct = snapshot.data![index];
                          return Card(
                            child: ListTile(
                              leading: Image.asset(
                                currentProduct.image,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                              title: Text(currentProduct.name),
                              subtitle: Text('Price: ${currentProduct.price} EGP'),
                              trailing: IconButton(
                                icon: Icon(Icons.remove_shopping_cart),
                                onPressed: () async {
                                  await db.removeCartItem(sharedPref.id!, currentProduct.id!);
                                  setState(() {
                                    ids.remove(currentProduct.id);
                                    getCartItems();
                                  });
                                },
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductDetailsPage(
                                      name: currentProduct.name,
                                      description: currentProduct.desc,
                                      imagePath: currentProduct.image,
                                      price: "${currentProduct.price} EGP",
                                      productId: currentProduct.id!,
                                      userId: sharedPref.id!,
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(child: Text('Your cart is empty.'));
                    }
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    'Total Price: $totalPrice EGP',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: (){
                      showDialog(context: context,
                          builder:(context) => AlertDialog(
                            title: Text('Payment'),
                            content: Text('خليها علينا المراي'),
                          )
                      );
                    },
                    child: Text('Pay'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
