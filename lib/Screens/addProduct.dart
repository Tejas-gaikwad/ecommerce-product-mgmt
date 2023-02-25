import 'package:appcart_task/providers/addproductProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  late TextEditingController productNameController;
  late TextEditingController productPriceController;
  late TextEditingController productQuanityAvailable;
  late TextEditingController productDiscountController;
  late TextEditingController productDescriptionController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productNameController = TextEditingController();
    productPriceController = TextEditingController();
    productQuanityAvailable = TextEditingController();
    productDiscountController = TextEditingController();
    productDescriptionController = TextEditingController();
  }

  addProductFunstion(BuildContext context) async {
    final addProductProvider =
        Provider.of<AddProductProvider>(context, listen: false);

    if (productNameController.text.isNotEmpty &&
        productPriceController.text.isNotEmpty &&
        productDiscountController.text.isNotEmpty &&
        productDescriptionController.text.isNotEmpty) {
      addProductProvider.addProduct(
        productNameController.text,
        productPriceController.text,
        productDiscountController.text,
        productDescriptionController.text,
        int.parse(productQuanityAvailable.text),
        context,
      );
      productNameController.clear();
      productPriceController.clear();
      productDiscountController.clear();
      productDescriptionController.clear();
      productQuanityAvailable.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please enter all details.")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product"),
      ),
      body: SafeArea(
          child: Container(
        height: height,
        width: width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              AddProductCards(
                controller: productNameController,
                hintText: "Product Name",
              ),
              AddProductCards(
                controller: productPriceController,
                hintText: "Product Price",
              ),
              AddProductCards(
                controller: productQuanityAvailable,
                hintText: "Product Quanity available",
              ),
              AddProductCards(
                controller: productDiscountController,
                hintText: "Product discount",
              ),
              AddProductCards(
                height: 150.0,
                controller: productDescriptionController,
                hintText: "Product Description",
              ),
              SizedBox(height: 50),
              Consumer<AddProductProvider>(
                builder: (context, addProductProvider, child) {
                  return InkWell(
                      onTap: () {
                        addProductFunstion(context);
                      },
                      child: AddButton());
                },
              ),
            ],
          ),
        ),
      )),
    );
  }
}

class AddProductCards extends StatelessWidget {
  final controller;
  final hintText;
  final height;
  final maxLines;
  const AddProductCards({
    super.key,
    required this.controller,
    required this.hintText,
    this.height,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        color: Colors.grey.withOpacity(0.2),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
        ),
      ),
    );
  }
}

class AddButton extends StatelessWidget {
  const AddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        color: Colors.blue,
      ),
      child: const Text(
        "ADD",
        style: TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
