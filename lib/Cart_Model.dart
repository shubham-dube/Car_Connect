import 'package:flutter/material.dart';
import './Screens/Merchant/ManageProductScreen/Manage_Screen.dart';
import './Screens/Merchant/ManageServiceScreen/Manage_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartModel extends ChangeNotifier {
  final List<Product> _inCartProducts = [];
  final List<Service> _inCartServices = [];

  int get itemCount => _inCartProducts.length + _inCartServices.length;

  void addItem(dynamic item , String type) {
    if(type == 'Product'){
      _inCartProducts.add(item);
      notifyListeners();
    }
    else if(type == 'Service'){
      _inCartServices.add(item);
      notifyListeners();
    }
  }

  void removeItem(dynamic item , String type) {
    if(type == 'Product'){
      _inCartProducts.remove(item);
      notifyListeners();
    }
    else if(type == 'Service'){
      _inCartServices.remove(item);
      notifyListeners();
    }
  }

  List<Product> get inCartProducts => _inCartProducts;
  List<Service> get inCartServices => _inCartServices;
}