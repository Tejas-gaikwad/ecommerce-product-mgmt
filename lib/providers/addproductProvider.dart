import 'package:appcart_task/model/productModel.dart';
import 'package:flutter/material.dart';

class AddProductProvider extends ChangeNotifier {
  List allProducts = [];
  addProduct(
      String productName,
      String productPrice,
      String productDiscount,
      String productDescription,
      int productQuantity,
      BuildContext context) async {
    allProducts.add({
      'productName': productName.toString(),
      'productPrice': productPrice.toString(),
      'productDiscount': productDiscount.toString(),
      'productDesciption': productDescription.toString(),
      'productQuantity': productQuantity,
    });

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Product added succesfully.")));

    notifyListeners();
  }
}
