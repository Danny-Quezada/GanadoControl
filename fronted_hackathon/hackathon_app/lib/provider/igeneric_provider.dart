import 'package:flutter/material.dart';
import 'package:flutter_provider_utilities/flutter_provider_utilities.dart';

mixin class IGenericProvider<T> {
  List<T>? list;

  T? t;

  void doNull(){
    this.list=null;
    t=null;
  }
}