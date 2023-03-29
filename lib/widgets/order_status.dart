import 'package:flutter/material.dart';

class OrderStatus extends StatelessWidget {
  final String statusValue;

  Color getColor(String status) {
    if (status == "1") return Colors.orange;
    if (status == "2") return Colors.green;
    if (status == "3") return Colors.grey;
    if (status == "4") return Colors.orange[700];
    if (status == "5") return Colors.green[700];
    if (status == "6") return Colors.red;
  }

  const OrderStatus({
    Key key,
    @required this.statusValue,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      width: 10,
      decoration: BoxDecoration(
          color: getColor(statusValue),
          borderRadius: BorderRadius.circular(10)),
    );
  }
}
