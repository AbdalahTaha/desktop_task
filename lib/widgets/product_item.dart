import 'package:flutter/material.dart';
import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  final int id;
  final String title;
  final String imageUrl;
  final int price;
  ProductItem(
      {required this.id,
      required this.title,
      required this.imageUrl,
      required this.price});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ProductDetailScreen(
                  productId: id,
                  imageUrl: imageUrl,
                  title: title,
                );
              },
            ),
          );
        },
        child: GridTile(
          child: Image.network(
            imageUrl,
            fit: BoxFit.contain,
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            title: Text(
              title,
              textAlign: TextAlign.center,
            ),
            trailing: Text(
              "${price.toString()} LE",
              style: TextStyle(color: Colors.deepOrange),
            ),
          ),
        ),
      ),
    );
  }
}
