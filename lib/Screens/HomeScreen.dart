import 'package:appcart_task/Screens/addToCart.dart';
import 'package:appcart_task/Screens/productDetails.dart';

import 'package:appcart_task/providers/addproductProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import 'addProduct.dart';
import 'constants/productCard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0),
            child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return AddToCartScreen();
                    },
                  ));
                },
                child: Icon(Icons.shopping_cart)),
          ),
        ],
      ),
      body: SafeArea(child: Consumer<AddProductProvider>(
        builder: (context, addProductPrvider, child) {
          return Container(
            color: Colors.white,
            height: height,
            width: width,
            child: addProductPrvider.allProducts.isEmpty
                ? const Center(
                    child: Text("NO PRODUCTS AVAILABLE"),
                  )
                : ListView.builder(
                    itemCount: addProductPrvider.allProducts.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return ProductDetails(
                                  index: index,
                                  productDescription: addProductPrvider
                                      .allProducts[index]['productDesciption']
                                      .toString(),
                                  productDiscount: addProductPrvider
                                      .allProducts[index]['productDiscount'],
                                  productName: addProductPrvider
                                      .allProducts[index]['productName']
                                      .toString(),
                                  productPrice: addProductPrvider
                                      .allProducts[index]['productPrice'],
                                  productQuantity: addProductPrvider
                                      .allProducts[index]['productQuantity'],
                                );
                              },
                            ));
                          },
                          child: ProductCard(
                            ProductQuantity: addProductPrvider
                                .allProducts[index]['productQuantity']
                                .toString(),
                            productDiscount: addProductPrvider
                                .allProducts[index]['productDiscount']
                                .toString(),
                            productPrice: addProductPrvider.allProducts[index]
                                    ['productPrice']
                                .toString(),
                            productName: addProductPrvider.allProducts[index]
                                    ['productName']
                                .toString(),
                            productQuantity: addProductPrvider
                                .allProducts[index]['productQuanity']
                                .toString(),
                          ));
                    },
                  ),
          );
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return const AddProduct();
            },
          ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
