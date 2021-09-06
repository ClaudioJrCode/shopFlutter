import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Product product =
        ModalRoute.of(context)?.settings.arguments as Product;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(product.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              height: 300,
              width: double.infinity,
              child: Image.network(product.imgUrl, fit: BoxFit.cover),
            ),
            SizedBox(height: 10),
            Text(
              'R\$${product.price}',
              style: TextStyle(fontSize: 25, color: Colors.grey),
            ),
            SizedBox(height: 10),
            Text(product.description, style: TextStyle(fontSize: 16))
          ],
        ),
      ),
    );
  }
}
