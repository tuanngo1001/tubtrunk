import 'User.dart';

class Reward
{
  String _m_Name;
  String _m_Description;
  bool _m_Unlocked;
  User _m_owner;

  Reward(this._m_Name)
  {
    this._m_Unlocked = false;
  }

  void setOwner(User owner)
  {
    this._m_owner = owner;
  }

  void unlock()
  {
    this._m_Unlocked = true;
  }
}


