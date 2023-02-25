// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    required this.data,
  });

  List<Datum> data;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.productName,
    required this.productPrice,
    required this.productDiscount,
    required this.productDescription,
    required this.patientGender,
  });

  int productName;
  String productPrice;
  String productDiscount;
  int productDescription;
  String patientGender;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        productName: json["product_name"],
        productPrice: json["product_price"],
        productDiscount: json["product_discount"],
        productDescription: json["product_description"],
        patientGender: json["patient_gender"],
      );

  Map<String, dynamic> toJson() => {
        "product_name": productName,
        "product_price": productPrice,
        "product_discount": productDiscount,
        "product_description": productDescription,
        "patient_gender": patientGender,
      };
}
