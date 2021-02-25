import 'User.dart';

class Reward
{
  String _m_Description;
  bool _m_Unlocked;
  User _m_owner;

  Reward(this._m_Description)
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

  String getDescription(){
    return _m_Description;
  }

  void setDescription(String newDescription){
    _m_Description = newDescription;
  }
}


