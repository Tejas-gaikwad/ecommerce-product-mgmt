import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final productName;
  final ProductQuantity;
  final productPrice;
  final productDiscount;
  final productQuantity;
  const ProductCard({
    super.key,
    required this.productName,
    required this.ProductQuantity,
    required this.productPrice,
    required this.productDiscount,
    required this.productQuantity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      height: 100,
      color: Colors.grey.withOpacity(0.2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text("Product Name : " + productName.toString())),
              SizedBox(width: 16),
              Expanded(child: Text("Product Quantity : " + ProductQuantity)),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text("Product Proce : " + productPrice)),
              SizedBox(width: 16),
              Expanded(child: Text("Product Discount : " + productDiscount)),
            ],
          ),
        ],
      ),
    );
  }
}
