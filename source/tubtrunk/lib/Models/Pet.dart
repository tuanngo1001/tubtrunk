import 'Reward.dart';

class Pet extends Reward
{
  String _rarity;
  Pet(String m_Name, this._rarity) :
        super(m_Name);
}