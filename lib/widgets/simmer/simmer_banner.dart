import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:svgs_app/constants/AppColors.dart';

class SimmerBanner extends StatefulWidget {
  @override
  _SimmerBannerState createState() => _SimmerBannerState();
}

class _SimmerBannerState extends State<SimmerBanner> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        height: 200.0,
        width: double.infinity,
        child: Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            enabled: true,
            child: ListView.builder(
                itemCount: 4,
                itemBuilder: (_, __) {
                  return Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 8.0),
                        width: 40.0,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                      SizedBox(
                        width: 4.0,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 8.0),
                              height: 10.0,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(2.0)),
                            ),
                            Container(
                              margin: const EdgeInsets.only(bottom: 8.0),
                              height: 10.0,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(2.0)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                })));
  }
}
