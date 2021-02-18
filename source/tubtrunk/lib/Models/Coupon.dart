import 'Reward.dart';

class Coupon extends Reward
{
  DateTime _expiration_Date;
  String _apply_To; //Superstore, Giant Tiger, Sobey, . . .

  Coupon(String m_Name, this._expiration_Date, this._apply_To) : super(m_Name);
}