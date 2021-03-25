import 'package:intl/intl.dart';
import 'package:tubtrunk/Models/userModel.dart';

class GlobalSettings {
  static String serverAddress = "https://tubtrunk.tk/";
  static DateFormat dateFormatted = DateFormat("MM/dd/yyyy");
  static DateFormat timeFormatted = DateFormat("HH:mm");
  static UserModel user;
}
