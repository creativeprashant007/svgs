import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:svgs_app/constants/AppColors.dart';

class FeaturedProductListSimmer extends StatefulWidget {
  @override
  _FeaturedProductListSimmerState createState() =>
      _FeaturedProductListSimmerState();
}

class _FeaturedProductListSimmerState extends State<FeaturedProductListSimmer> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 10.0, right: 10.0),
        width: double.infinity,
        child: Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            enabled: true,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (_, __) {
                  return Container(
                    height: 355,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 90.0,
                          height: 16,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(0.0)),
                        ),
                        SizedBox(height: 10.0),
                        Container(
                          margin: const EdgeInsets.only(bottom: 8.0),
                          width: 175.0,
                          height: 175.0,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 8.0),
                              width: 70.0,
                              height: 14.0,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(0.0)),
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              margin: const EdgeInsets.only(bottom: 8.0),
                              width: 85.0,
                              height: 14.0,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(2.0)),
                            ),
                          ],
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.only(bottom: 8.0),
                          width: 175.0,
                          height: 10.0,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(2.0)),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.only(bottom: 8.0),
                          width: 175.0,
                          height: 10.0,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(2.0)),
                        ),
                      ],
                    ),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 15.0),
                  );
                })));
  }
}
