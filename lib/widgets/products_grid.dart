import 'package:flutter/material.dart';
import './product_item.dart';
import '../services/fetch_all_products.dart';

class ProductsGrid extends StatefulWidget {
  @override
  _ProductsGridState createState() => _ProductsGridState();
}

class _ProductsGridState extends State<ProductsGrid> {
  var listOfItems = [];
  bool _isLoading = false;
  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    fetchAllProducts().getProducts().then((value) => {
          setState(() {
            listOfItems = value;
            _isLoading = false;
          }),
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : GridView.builder(
            padding: const EdgeInsets.all(10.0),
            itemCount: listOfItems.length,
            itemBuilder: (context, i) => ProductItem(
              id: listOfItems[i]['product_id'],
              title: listOfItems[i]['title'],
              imageUrl: listOfItems[i]['picture'],
              price: listOfItems[i]['sizes'][0]['price'],
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0),
          );
  }
}
