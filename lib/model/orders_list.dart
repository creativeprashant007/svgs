class Orders {
  final String id;
  final String userId;
  final String goFrugalId;
  final String goFrugalMsg;
  final String orderShowId;
  final String orderBranchId;
  final String orderDeliverType;
  final String orderDeliverDate;
  final String orderDeliverFromTime;
  final String orderDeliverToTime;
  final String orderShippingId;
  final String subTotal;
  final String order_itemcount;
  final String shipping;
  final String discount;
  final String paymentStatus;
  final String shippingStatus;
  final String status;
  final String updatedBy;
  final String tax;
  final String total;
  final String currency;
  final String exchangeRate;
  final String received;
  final String balance;
  final String firstName;
  final String lastName;
  final String address1;
  final String address2;
  final String city;
  final String state;
  final String country;
  final String company;
  final String postCode;
  final String phone;
  final String email;
  final String comment;
  final String paymentMethod;
  final String shippingMethod;
  final String needProd;
  final String userAgent;
  final String ip;
  final String transaction;
  final String createdAt;
  final String updatedAt;

  Orders({
    this.id,
    this.userId,
    this.goFrugalId,
    this.goFrugalMsg,
    this.order_itemcount,
    this.orderShowId,
    this.orderBranchId,
    this.orderDeliverType,
    this.orderDeliverDate,
    this.orderDeliverFromTime,
    this.orderDeliverToTime,
    this.orderShippingId,
    this.subTotal,
    this.shipping,
    this.discount,
    this.paymentStatus,
    this.shippingStatus,
    this.status,
    this.updatedBy,
    this.tax,
    this.total,
    this.currency,
    this.exchangeRate,
    this.received,
    this.balance,
    this.firstName,
    this.lastName,
    this.address1,
    this.address2,
    this.city,
    this.state,
    this.country,
    this.company,
    this.postCode,
    this.phone,
    this.email,
    this.comment,
    this.paymentMethod,
    this.shippingMethod,
    this.needProd,
    this.userAgent,
    this.ip,
    this.transaction,
    this.createdAt,
    this.updatedAt,
  });
}

class StatusOrder {
  final String status1;
  final String status2;
  final String status3;
  final String status4;
  final String status5;
  final String status6;

  StatusOrder({
    this.status1,
    this.status2,
    this.status3,
    this.status4,
    this.status5,
    this.status6,
  });
}

class OrderDetails {
  final String id;
  final String order_id;
  final String product_id;
  final String item_id;
  final String name;
  final String price;
  final String qty;
  final String total_price;
  final String tax;
  final String sku;
  final String currency;
  final String exchange_rate;
  final String attribute;
  final String created_at;
  final String updated_at;

  OrderDetails({
    this.id,
    this.order_id,
    this.product_id,
    this.item_id,
    this.name,
    this.price,
    this.qty,
    this.total_price,
    this.tax,
    this.sku,
    this.currency,
    this.exchange_rate,
    this.attribute,
    this.created_at,
    this.updated_at,
  });
}
