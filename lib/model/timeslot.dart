class StandardDate {
  final String date;
  final int date_pos;
  bool isSelect;

  StandardDate({
    this.date,
    this.isSelect = false,
    this.date_pos,
  });
}

class StandardDelivery {
  final String id;
  final String fromTime;
  final String toTime;
  final String noOfOrders;
  bool isSelect;
  final int time_pos;

  StandardDelivery({
    this.id,
    this.fromTime,
    this.toTime,
    this.noOfOrders,
    this.time_pos,
    this.isSelect = false,
  });
}
