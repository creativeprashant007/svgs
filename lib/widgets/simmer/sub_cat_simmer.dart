import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SubCatSimmer extends StatefulWidget {
  @override
  SubCatSimmerState createState() => SubCatSimmerState();
}

class SubCatSimmerState extends State<SubCatSimmer> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
        height: 30.0,
        width: double.infinity,
        child: Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            enabled: true,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 8,
                itemBuilder: (_, __) {
                  return Container(
                    margin: const EdgeInsets.only(right: 4.0),
                    width: 80.0,
                    height: 30.0,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0)),
                    child: Card(),
                  );
                })));
  }
}
