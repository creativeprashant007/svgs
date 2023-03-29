import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:svgs_app/constants/AppColors.dart';

class ProductListSimmer extends StatefulWidget {
  @override
  _ProductListSimmerState createState() => _ProductListSimmerState();
}

class _ProductListSimmerState extends State<ProductListSimmer> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        width: double.infinity,
        child: Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            enabled: true,
            child: ListView.builder(
                itemCount: 5,
                itemBuilder: (_, __) {
                  return Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 8.0),
                        width: 150.0,
                        height: 150.0,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                      SizedBox(
                        width: 4.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 8.0),
                            width: 200.0,
                            height: 18.0,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(2.0)),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            margin: const EdgeInsets.only(bottom: 8.0),
                            width: 180.0,
                            height: 18.0,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(2.0)),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            margin: const EdgeInsets.only(bottom: 8.0),
                            width: 200.0,
                            height: 18.0,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(2.0)),
                          ),
                          Row(
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                margin: const EdgeInsets.only(bottom: 8.0),
                                width: 90.0,
                                height: 15.0,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(2.0)),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                margin: const EdgeInsets.only(bottom: 8.0),
                                width: 90.0,
                                height: 15.0,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(2.0)),
                              ),
                            ],
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            margin: const EdgeInsets.only(bottom: 8.0),
                            width: 80.0,
                            height: 30.0,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(2.0)),
                          ),
                        ],
                      ),
                    ],
                  );
                })));
  }
}
