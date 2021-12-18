import 'dart:convert';
import 'package:http/http.dart' as http;
import './authentication.dart';

class FetchProductDetails {
  late final _itemDetails;
  List<String> _availableSizes = [];
  getProductDetails(int id) async {
    try {
      final response = await http.get(
        Uri.parse('https://pos-app.com/public/api/products/$id'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${Authenticate.accessToken}'
        },
      );
      _itemDetails = jsonDecode(response.body)[0] as Map<String, dynamic>;
    } catch (e) {
      throw e;
    }
  }

  List<String> getListOfSizes() {
    //return list of available sizes
    [..._itemDetails['sizes']].forEach((size) {
      _availableSizes.add(size['size']);
    });
    return _availableSizes;
  }

  int getPriceOfSelectedSize(String size) {
    //return price of selected size
    Map<String, dynamic> selectedSizeDetails = [..._itemDetails['sizes']]
        .firstWhere((sizeDetails) => sizeDetails['size'] == size);
    int priceOfSize = selectedSizeDetails['price'];
    return priceOfSize;
  }

  Map<String, String> getAvailableColorsOfSize(String size) {
    //return map of available colors {hexadecimal:color}
    Map<String, String> mapOfAvailableColors = {};
    Map<String, dynamic> selectedSizeDetails = [..._itemDetails['sizes']]
        .firstWhere((sizeDetails) => sizeDetails['size'] == size);
    List<Map<String, dynamic>> AvailableColorsDetails = [
      ...selectedSizeDetails['available_colors'][0]
    ];
    AvailableColorsDetails.forEach((color) {
      mapOfAvailableColors.addAll({color['hexadecimal']: color['color']});
    });
    return mapOfAvailableColors;
  }
}
