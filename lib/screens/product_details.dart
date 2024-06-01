import 'package:flutter/material.dart';
import 'package:shopping_app/database/database_handler.dart';
import 'package:shopping_app/screens/cart.dart';

class ProductDetailsPage extends StatefulWidget {
  final String name;
  final String description;
  final String imagePath;
  final String price;
  final int productId;
  final int userId;

  ProductDetailsPage({
    required this.name,
    required this.description,
    required this.imagePath,
    required this.price,
    required this.productId,
    required this.userId,
  });

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  final dbHelper = DataBaseHandler();

  void _addToCart() async {
    await dbHelper.insertCart(widget.userId, widget.productId);

    // print
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Item Added To Cart')),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Cart()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("تفاصيل المنتج"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              widget.imagePath,
              width: MediaQuery.of(context).size.width / 1.1,
              height: 500,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              widget.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            SizedBox(height: 5),
            Text(
              widget.price,
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10),
            Text(
              widget.description,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addToCart,
              child: Text("أضف إلى السلة"),
            ),
          ],
        ),
      ),
    );
  }
}
