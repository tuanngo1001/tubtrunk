import 'package:flutter_test/flutter_test.dart';
import 'package:tubtrunk/Controllers/storeController.dart';
import 'package:tubtrunk/Models/couponModel.dart';

void main() {
  group('storeController Tests', () {
    group('Initialization Test', () {
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

    group('storeController Functions Test', () {
      test("getCouponList should return a List<CouponModel>", () {
        //Arrange
        StoreController testStoreController = new StoreController();
        //Act
        Future<List<CouponModel>> testCouponList = testStoreController.loadCouponList();
        //Assert
        testCouponList.then((value) {
          expect((testCouponList is List<CouponModel>), true);
        });
      });

      test("removeCouponAtIndex should remove the correct item", () {
        //Arrange
        StoreController testStoreController = new StoreController();
        CouponModel testCoupon = new CouponModel();
        Future<List<CouponModel>> testCouponList = testStoreController.loadCouponList();
        //Act
        testCouponList.then((value) {
          int currentSize = (testCouponList as List<CouponModel>).length;
          (testCouponList as List<CouponModel>).add(testCoupon);
          testStoreController.removeCouponAtIndex(currentSize - 1);

          //Assert
          expect((testCouponList as List<CouponModel>).length, currentSize - 1);
        });
      });

      test("remove invalid index does not affect CouponList", () {
        //Arrange
        StoreController testStoreController = new StoreController();
        CouponModel testCoupon = new CouponModel();
        Future<List<CouponModel>> testCouponList = testStoreController.loadCouponList();
        //Act
        testCouponList.then((value) {
          int currentSize = (testCouponList as List<CouponModel>).length;
          List<CouponModel> beforeList1 = testCouponList as List<CouponModel>;
          (testCouponList as List<CouponModel>).add(testCoupon);
          testStoreController.removeCouponAtIndex(currentSize + 10);

          //Assert
          expect((testCouponList as List<CouponModel>), beforeList1);

          //Act test negative index
          List<CouponModel> beforeList2 = testCouponList as List<CouponModel>;
          testStoreController.removeCouponAtIndex(-100);
          //Assert
          expect((testCouponList as List<CouponModel>), beforeList2);
        });
      });
    });
  });
}
