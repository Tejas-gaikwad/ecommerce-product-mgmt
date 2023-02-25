import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ProductDetailsEdit extends StatefulWidget {
  final details;
  final name;
  final quantity;
  final price;
  final discount;
  ProductDetailsEdit(
      {super.key,
      required this.details,
      required this.name,
      required this.quantity,
      required this.price,
      required this.discount});

  @override
  State<ProductDetailsEdit> createState() => _ProductDetailsEditState();
}

class _ProductDetailsEditState extends State<ProductDetailsEdit> {
  late TextEditingController descriptionController;
  late TextEditingController nameController;
  late TextEditingController quantityController;
  late TextEditingController priceController;
  late TextEditingController discountController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    descriptionController =
        TextEditingController(text: widget.details.toString());
    nameController = TextEditingController(text: widget.name.toString());
    quantityController =
        TextEditingController(text: widget.quantity.toString());
    priceController = TextEditingController(text: widget.price.toString());
    discountController =
        TextEditingController(text: widget.discount.toString());
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Details Edit"),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: height,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    EditContainer(
                      controller: nameController,
                    ),
                    EditContainer(
                      controller: quantityController,
                    ),
                    EditContainer(
                      controller: priceController,
                    ),
                    EditContainer(
                      controller: discountController,
                    ),
                    Description(
                      details: widget.details,
                      controller: descriptionController,
                    ),
                    SizedBox(height: 40),
                    DoneOrAdd(),
                    SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EditContainer extends StatelessWidget {
  final controller;
  const EditContainer({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      alignment: Alignment.center,
      width: width,
      padding: const EdgeInsets.symmetric(vertical: 04, horizontal: 10),
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
      color: Colors.grey.withOpacity(0.2),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class DoneOrAdd extends StatelessWidget {
  const DoneOrAdd({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Edited.")));
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 60),
          color: Colors.blueAccent,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          child: const Text(
            "Done",
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

class Description extends StatelessWidget {
  final details;
  final controller;
  const Description(
      {super.key, required this.details, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      margin: const EdgeInsets.symmetric(horizontal: 12),
      color: Colors.grey.withOpacity(0.2),
      child: TextField(
          controller: controller,
          maxLines: 6,
          decoration: InputDecoration(
            border: InputBorder.none,
          )),
    );
  }
}
