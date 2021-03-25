class CouponModel {
  //Coupon attributes
  int id;
  String code;
  String store;
  String discount;
  String description; //Already in the super class
  DateTime expireDate;
  String price;

  CouponModel(
      {this.id,
      this.code,
      this.store,
      this.discount,
      this.description,
      this.expireDate}) {
    price = "300";
  }

  factory CouponModel.fromJson(Map<String, dynamic> json) {
    return CouponModel(
      id: int.parse(json['ID']),
      code: json['Code'],
      store: json['Store'],
      discount: json['Discount'],
      description: json['Description'],
      expireDate: DateTime.parse(json['ExpireDate']),
    );
  }

  @override
  String toString() {
    return "ID: " + id.toString() + "description " + description;
  }
}
