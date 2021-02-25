import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Pet
{
  String rarity;
  String name;
  String description;
  String price;
  Pet(this.name, this.rarity, this.description){
    price = "\$100";
  }

}