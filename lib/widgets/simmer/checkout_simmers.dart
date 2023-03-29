import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:svgs_app/constants/AppColors.dart';

class DeliveryAddressSimmer extends StatefulWidget {
  @override
  _DeliveryAddressSimmerState createState() => _DeliveryAddressSimmerState();
}

class _DeliveryAddressSimmerState extends State<DeliveryAddressSimmer> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        height: 230.0,
        width: double.infinity,
        child: Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            enabled: true,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (_, __) {
                  return Container(
                    margin: const EdgeInsets.only(right: 8.0),
                    width: 200.0,
                    height: 200,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0)),
                    child: Card(),
                  );
                })));
  }
}

class DeliveryDateSimmer extends StatefulWidget {
  @override
  _DeliveryDateSimmerState createState() => _DeliveryDateSimmerState();
}

class _DeliveryDateSimmerState extends State<DeliveryDateSimmer> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        height: 120.0,
        width: double.infinity,
        child: Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            enabled: true,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (_, __) {
                  return Container(
                    padding: const EdgeInsets.all(10.0),
                    margin: const EdgeInsets.all(5.0),
                    width: 100.0,
                    height: 100,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Card(),
                  );
                })));
  }
}
