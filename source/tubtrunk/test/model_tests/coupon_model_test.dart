import 'package:flutter_test/flutter_test.dart';
import 'package:tubtrunk/Models/couponModel.dart';

void main(){
  group('Initialization Test', () {
    test("The coupon instance should display all attributes correctly", () {
      //Arrange
      DateTime today = new DateTime.now();
      //Act
      CouponModel testCoupon = new CouponModel(id: 1, code:"2", store:"3", discount: "4",description: "5",expireDate: today);
      //Assert
      expect(testCoupon.id, 1);
      expect(testCoupon.code, "2");
      expect(testCoupon.store, "3");
      expect(testCoupon.discount, "4");
      expect(testCoupon.description, "5");
      expect(testCoupon.expireDate, today);
    });
  });

  group('Function Test', () {
    test("The coupon .fromJson should display all attributes correctly", () {
      //Arrange
      String date = "2021-03-18";
      DateTime today = DateTime.parse(date);
      var json = new Map<String, dynamic>();
      json['ID'] = '1';
      json['Code'] = '2';
      json['Store'] = '3';
      json['Discount'] = '4';
      json['Description'] = '5';
      json['ExpireDate'] = date;

      //Act
      var testCoupon = CouponModel.fromJson(json);
      //Assert
      expect(testCoupon.id, 1);
      expect(testCoupon.code, "2");
      expect(testCoupon.store, "3");
      expect(testCoupon.discount, "4");
      expect(testCoupon.description, "5");
      expect(testCoupon.expireDate, today);
    });
  });
}