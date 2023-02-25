import 'package:appcart_task/Screens/productDetailsEdit.dart';
import 'package:appcart_task/providers/addToCardProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  final index;
  final productName;
  final productDiscount;
  final productQuantity;
  final productPrice;
  final productDescription;
  const ProductDetails(
      {super.key,
      required this.index,
      required this.productName,
      required this.productDiscount,
      required this.productPrice,
      required this.productDescription,
      required this.productQuantity});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  var quantityData;
  var totalPrice;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    quantityData = 0;
    totalPrice = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Details"),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return ProductDetailsEdit(
                    details: widget.productDescription.toString(),
                    name: widget.productName.toString(),
                    discount: widget.productDiscount,
                    price: widget.productPrice,
                    quantity: widget.productQuantity,
                  );
                },
              ));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              child: const Text(
                "Edit",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 12),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 12),
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
                            Text("Product name : ${widget.productName}"),
                            Text(
                                "Quantity : ${widget.productQuantity.toString()}"),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Price : ${widget.productPrice.toString()}"),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 3,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () {
                                  if (quantityData <= 0) {
                                    setState(() {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "Hey, Something is wrong.")));
                                    });
                                  } else {
                                    setState(() {
                                      quantityData = quantityData - 1;
                                      totalPrice =
                                          (int.parse(widget.productPrice) *
                                              quantityData);
                                    });
                                  }
                                },
                                child: Container(
                                  color: Colors.grey.withOpacity(0.2),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 10),
                                  child: const Text("-"),
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Text(quantityData.toString()),
                              ),
                              InkWell(
                                onTap: () {
                                  if (quantityData >= widget.productQuantity) {
                                    setState(() {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "Hey, Something is wrong.")));
                                    });
                                  } else {
                                    setState(() {
                                      quantityData = quantityData + 1;
                                      totalPrice =
                                          (int.parse(widget.productPrice) *
                                              quantityData);
                                    });
                                  }
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  color: Colors.grey.withOpacity(0.2),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 10),
                                  child: const Text("+"),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text("Total Price  : ${totalPrice}")
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Description(
                      details: widget.productDescription == null
                          ? "No description available "
                          : widget.productDescription.toString(),
                    ),
                  ),
                ],
              ),
            ),
            AddToCart(
              productDescription: widget.productDescription,
              productDiscount: widget.productDiscount,
              productName: widget.productName,
              productPrice: totalPrice,
              productquantity: quantityData,
            ),
          ],
        ),
      ),
    );
  }
}

class Description extends StatelessWidget {
  final details;
  const Description({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Text(details),
    );
  }
}

class AddToCart extends StatelessWidget {
  final productName;
  final productPrice;
  final productDiscount;
  final productDescription;
  final productquantity;

  const AddToCart({
    super.key,
    this.productName,
    this.productPrice,
    this.productDiscount,
    this.productDescription,
    this.productquantity,
  });

  @override
  Widget build(BuildContext context) {
    final addToCartProvider =
        Provider.of<AddToCartProvider>(context, listen: false);
    return Align(
      alignment: Alignment.bottomCenter,
      child: InkWell(
        onTap: () {
          // Add to cart function..............
          addToCartProvider.addProductToCart(
            productName,
            productPrice,
            int.parse(productDiscount),
            productDescription,
            productquantity,
            context,
          );
        },
        child: Container(
          color: Colors.blueAccent,
          margin: const EdgeInsets.symmetric(vertical: 50),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          child: const Text(
            "Add to cart",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
