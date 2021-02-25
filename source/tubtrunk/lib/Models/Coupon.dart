import 'package:flutter/material.dart';
import 'dart:convert';

class Coupon
{
  //Coupon attributes
  int id;
  String code;
  String store;
  String discount;
  String description;  //Already in the super class
  DateTime expireDate;
  String price;

  Coupon({this.id, this.code, this.store, this.discount, this.description, this.expireDate}){
    price = "\$69.96";
  }


  factory Coupon.fromJson(Map< String, dynamic> json){
    return Coupon(
      id: int.parse(json['ID']),
      code: json['Code'],
      store: json['Store'],
      discount: json['Discount'],
      description:json['Description'],
      expireDate: DateTime.parse(json['ExpireDate']),
    );
  }

  @override
  String toString() {
    // TODO: implement toString
    return "ID: "+id.toString()+ "description "+ description;

  }
}