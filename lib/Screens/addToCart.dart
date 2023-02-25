import 'package:appcart_task/providers/addToCardProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Screens/constants/productCard.dart';
import '../Screens/productDetails.dart';

class AddToCartScreen extends StatefulWidget {
  const AddToCartScreen({super.key});

  @override
  State<AddToCartScreen> createState() => _AddToCartScreenState();
}

class _AddToCartScreenState extends State<AddToCartScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    totalPrice();
  }

  var totalPriceofPrducts = 0;
  var totalTaxofPrducts = 0.0;
  var totalDiscountofPrducts = 0;

  var totalDiscount = 0;
  double totalTax = 0.0;
  var finalPrice = 0.0;

  var totalEstimatedPricePrducts = 0;

  bool isLOading = false;

  totalPrice() async {
    setState(() {
      isLOading = true;
    });
    final addToCartProvider =
        await Provider.of<AddToCartProvider>(context, listen: false);
    print("LENGTH ${addToCartProvider.cartProducts.length}");

    for (int i = 0; i < addToCartProvider.cartProducts.length; i++) {
      totalPriceofPrducts = totalPriceofPrducts +
          int.parse(addToCartProvider.cartProducts[i]['productPrice']);

      print(" ${i} th LOOP --- TOTAL PRICE OF PRODUCTS -- " +
          totalPriceofPrducts.toString());

      totalDiscountofPrducts = totalDiscountofPrducts +
          int.parse(
              addToCartProvider.cartProducts[i]['productDiscount'].toString());
    }
    var onePercentOfTotal = totalPriceofPrducts / 100;
    totalDiscount = totalDiscountofPrducts;
    totalTax = onePercentOfTotal * 5;

    var totalDiscountPrice = onePercentOfTotal * totalDiscount;
    print(" ${0} th LOOP --- TOTAL DISCOUNT ON ALL PRODUCTS -- " +
        totalDiscountPrice.toString());

    finalPrice = (totalTax + totalPriceofPrducts) - totalDiscountPrice;

    setState(() {
      isLOading = false;
    });
  }

  // totalTax() {}

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Consumer<AddToCartProvider>(
            builder: (context, addToCartProvider, child) {
              return Container(
                color: Colors.white,
                child: addToCartProvider.cartProducts.isEmpty
                    ? const Center(
                        child: Text("NO PRODUCTS AVAILABLE"),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: addToCartProvider.cartProducts.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return ProductDetails(
                                      index: index,
                                      productDescription: addToCartProvider
                                          .cartProducts[index]
                                              ['productDesciption']
                                          .toString(),
                                      productDiscount: addToCartProvider
                                          .cartProducts[index]
                                              ['productDiscount']
                                          .toString(),
                                      productName: addToCartProvider
                                          .cartProducts[index]['productName']
                                          .toString(),
                                      productPrice: addToCartProvider
                                          .cartProducts[index]['productPrice']
                                          .toString(),
                                      productQuantity:
                                          addToCartProvider.cartProducts[index]
                                              ['productQuantity'],
                                    );
                                  },
                                ));
                              },
                              child: ProductCard(
                                ProductQuantity: addToCartProvider
                                    .cartProducts[index]['productQuantity']
                                    .toString(),
                                productDiscount: addToCartProvider
                                    .cartProducts[index]['productDiscount']
                                    .toString(),
                                productPrice: addToCartProvider
                                    .cartProducts[index]['productPrice']
                                    .toString(),
                                productName: addToCartProvider
                                    .cartProducts[index]['productName']
                                    .toString(),
                                productQuantity: addToCartProvider
                                    .cartProducts[index]['productQuantity']
                                    .toString(),
                              ));
                        },
                      ),
              );
            },
          ),
          SizedBox(height: 40),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: const Text(
                "TOTAL",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          isLOading == true
              ? Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                )
              : Consumer<AddToCartProvider>(
                  builder: (context, addToCartProvider, child) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 12),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 12),
                      color: Colors.grey.withOpacity(0.2),
                      child: Column(
                        children: [
                          CartCard(
                            leftIndex: "Total Price",
                            rightIndex: totalPriceofPrducts,
                          ),
                          CartCard(
                            leftIndex: "Toal tax 5%",
                            rightIndex: totalTax.toString(),
                          ),
                          CartCard(
                            leftIndex: "Toal Discount",
                            rightIndex: "${totalDiscount.toString()}%",
                          ),
                          CartCard(
                            leftIndex: "Total Estimated price",
                            rightIndex: finalPrice.toString(),
                          ),
                        ],
                      ),
                    );
                  },
                )
        ],
      )),
    );
  }
}

class CartCard extends StatelessWidget {
  final rightIndex;
  final leftIndex;
  const CartCard(
      {super.key, required this.rightIndex, required this.leftIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 06),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(leftIndex.toString()),
          Text(rightIndex.toString()),
        ],
      ),
    );
  }
}
