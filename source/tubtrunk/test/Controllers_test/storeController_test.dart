import 'package:flutter_test/flutter_test.dart';
import 'package:tubtrunk/Controllers/storeController.dart';
import 'package:tubtrunk/Models/couponModel.dart';
import 'package:tubtrunk/Views/myCouponIcon.dart';


void main() {

  group('storeController Tests',(){

    group('Initialization Test',(){
      test("The storeController instance should be not null", () {
        //Arrange
        //Act
        StoreController testStoreController = new StoreController();
        //Assert
        expect(testStoreController, isNotNull);
      });

      test("couponList variable shouldn't be null", () {
        //Arrange
        //Act
        StoreController testStoreController = new StoreController();
        //Assert
        expect(testStoreController.couponList, isNotNull);
      });
    });

    group('storeController Functions Test',(){
      test("getCouponList should return a List<CouponModel>", () {
        //Arrange
        StoreController testStoreController = new StoreController();
        //Act
        Future<List<CouponModel>> testCouponList = testStoreController.getCouponList();
        //Assert
        testCouponList.then((value) {
          expect((testCouponList is List<CouponModel>), true);
        });
      });

      test("couponList variable shouldn't be null", () {
        //Arrange
        StoreController testStoreController = new StoreController();
        //Act
        //Assert
        //expect(testStoreController.couponList, isNotNull);
      });
    });
  });
}