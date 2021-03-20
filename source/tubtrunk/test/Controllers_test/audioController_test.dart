import 'package:flutter_test/flutter_test.dart';
import 'package:tubtrunk/Controllers/audioController.dart';

void main(){
  group('audioController Tests',(){
    group('Initialization Test',(){
      test("The storeController instance should be not null", () {
        //Arrange
        //Act
        AudioController testAudioController = new AudioController();
        //Assert
        expect(testAudioController, isNotNull);
      });

      test("couponList variable shouldn't be null", () {
        //Arrange
        //Act
        AudioController testAudioController = new AudioController();
        //Assert
        expect(testAudioController.getMusics(), isNotNull);
      });
    });

    group('Functions Test',(){
      test("getMusicsPrice return 99", () {
        //Arrange
        AudioController testAudioController = new AudioController();
        int expectPrice = 99;
        //Act
        int actualPrice = testAudioController.getMusicPrice();
        //Assert
        expect(actualPrice, expectPrice);
      });
    });
  });
  }