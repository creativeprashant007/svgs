class ProductAddToCartRequest {
  String productId;
  String itemId;
  String qty;
  String uniqueId;
  String mem_id;
  String branch_id;
  ProductAddToCartRequest({
    this.productId,
    this.itemId,
    this.qty,
    this.uniqueId,
    this.mem_id,
    this.branch_id,
  });
}
