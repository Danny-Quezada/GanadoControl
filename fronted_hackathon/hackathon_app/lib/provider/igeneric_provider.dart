import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_provider_utilities/flutter_provider_utilities.dart';

mixin class IGenericProvider<T> {
  List<T>? list;
  List<T>? searchList;
  T? t;
  int selectedQuantity=0;
  void doNull(){
    this.list=null;
    t=null;
    selectedQuantity=0;
    searchList=null;
  }
}