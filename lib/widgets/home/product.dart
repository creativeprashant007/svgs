import 'package:flutter/material.dart';
import 'package:svgs_app/src/item_details.dart';
import 'dart:convert';

class ProductDetails extends StatelessWidget {
  final String productId;
  final String productName;
  final String productImage;
  final String productPrice;
  final String productOldPrice;

  const ProductDetails({
    Key key,
    @required this.productId,
    @required this.productName,
    @required this.productImage,
    @required this.productPrice,
    @required this.productOldPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double savePrice =
        double.parse(productOldPrice) - double.parse(productPrice);
    return Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      width: 170.0,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return Item_Details();
                },
              ));
            },
            child: Container(
              height: 150.0,
              child: Image.network(
                productImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Wrap(
            spacing: 8.0, // gap between adjacent chips
            runSpacing: 4.0, // gap between lines
            direction: Axis.horizontal, //
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '₹ ${productPrice}',
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              Text(
                '₹ ${productOldPrice}',
                style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.lineThrough,
                    decorationColor: const Color(0xff000000),
                    color: Colors.grey),
              ),
            ],
          ),
          Container(
            width: 150.0,
            child: Text(
              'Save ${savePrice.toStringAsFixed(2)}',
              style: TextStyle(
                color: Colors.green,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(0.0),
            child: Text(
              '${productName}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
            ),
          ),
          Container(
            width: double.infinity,
            child: FlatButton.icon(
              color: Colors.blue,
              onPressed: () {},
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              label: Text('Add',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          )
        ],
      ),
    );
  }
}
