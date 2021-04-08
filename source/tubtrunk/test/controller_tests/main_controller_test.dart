import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:tubtrunk/Controllers/main_controller.dart';
import 'package:mockito/mockito.dart';
import 'package:tubtrunk/Utils/global_settings.dart';
import 'package:http/http.dart' as http;
import 'package:tubtrunk/Models/userModel.dart';

import 'main_controller_test.mocks.dart';

@GenerateMocks([TabController, http.Client])
void main() {
  group('mainController tests', () {
    test('changeMainView test', () {
      MainController mainController = MainController();
      mainController.tabController = MockTabController();
      // mock tab controller
      when(mainController.tabController.animateTo(1)).thenAnswer((realInvocation) { });
      expect(mainController.selectedIndex, 0);
      mainController.changeMainView(1);
      expect(mainController.selectedIndex, 1);
    });

    test('addMoney test', () {
      MainController mainController = MainController();

      int amountToAdd = 10;
      http.Client mockClient = MockClient();
      GlobalSettings.user = new UserModel.forNow(uID: 1, money: 100);
      var map = new Map<String, String>();
      map["UserID"] = GlobalSettings.user.uID.toString();
      map["UserMoney"] = (GlobalSettings.user.money + amountToAdd).toString();
      when(mockClient.post(GlobalSettings.serverAddress + "updateUserMoney.php", body: map)).thenAnswer((_) async => http.Response('', 200));

      mainController.addMoney(amountToAdd, clientParameter: mockClient);
      expect(GlobalSettings.user.money, 100 + amountToAdd);
    });
  });
}


