import 'package:flutter/material.dart';
import '../services/fetch_product_details.dart';

class ProductDetailScreen extends StatefulWidget {
  final productId;
  final imageUrl;
  final title;
  ProductDetailScreen({this.productId, this.imageUrl, this.title});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  FetchProductDetails _product = FetchProductDetails();
  late List<String> availableSizes;
  var selectedSize;
  late int price;
  late Map<String, String> availableColors;
  List<Widget> availableColorsList = [];
  bool _isLoading = false;
  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    _product.getProductDetails(widget.productId).then((_) => {
          setState(() {
            availableSizes = _product.getListOfSizes();
            selectedSize = availableSizes.first;
            updateUI(selectedSize);
            _isLoading = false;
          }),
        });
    super.initState();
  }

  void updateUI(String size) {
    setState(() {
      availableColorsList.clear();
      price = _product.getPriceOfSelectedSize(size);
      availableColors = _product.getAvailableColorsOfSize(size);
      availableColors.forEach((key, value) {
        availableColorsList.add(
          Container(
            color: Colors.blueAccent,
            child: ListTile(
              dense: true,
              minLeadingWidth: 1,
              title: Text(value),
              leading: Icon(
                Icons.circle,
                color: Color(int.parse(("0xff") + key)),
              ),
            ),
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      color: Colors.white,
                      height: MediaQuery.of(context).size.height / 3,
                      width: double.infinity,
                      child: Image.network(
                        widget.imageUrl,
                        fit: BoxFit.contain,
                      )),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.blue, width: 3)),
                    child: DropdownButton(
                      items: availableSizes.map(buildMenuItemSize).toList(),
                      value: selectedSize,
                      isDense: true,
                      onChanged: (v) {
                        setState(() {
                          selectedSize = v;
                          updateUI(selectedSize);
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 20.0),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: "Price:",
                            style:
                                TextStyle(color: Colors.black, fontSize: 20)),
                        TextSpan(
                            text: "$price",
                            style: TextStyle(color: Colors.red, fontSize: 25)),
                        TextSpan(
                            text: " LE",
                            style: TextStyle(color: Colors.black, fontSize: 20))
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "available colors",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                      ...availableColorsList,
                    ],
                  )
                ],
              ),
            ),
    );
  }

  DropdownMenuItem<String> buildMenuItemSize(String itemSize) {
    return DropdownMenuItem(
        value: itemSize,
        child: Text(
          itemSize,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ));
  }
}
