import 'package:flutter/material.dart';

class AddToCartProvider extends ChangeNotifier {
  List cartProducts = [];
  addProductToCart(
      String productName,
      int productPrice,
      int productDiscount,
      String productDescription,
      int productQuantity,
      BuildContext context) async {
    cartProducts.add({
      'productName': productName.toString(),
      'productPrice': productPrice.toString(),
      'productDiscount': productDiscount,
      'productDesciption': productDescription.toString(),
      'productQuantity': productQuantity,
    });

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Product added to Cart succesfully.")));

    notifyListeners();
  }
}
