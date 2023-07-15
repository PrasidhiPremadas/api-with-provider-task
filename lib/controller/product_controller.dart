import 'dart:convert';

import 'package:api_integration_rs/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart'as http;

class ProductProvider extends ChangeNotifier {
  static const uri = 'https://dummyjson.com/products';

  bool isLoading = true;
  String error = '';
  Products product = Products(products: [], total: 10, skip: 10, limit: 10);
  getDataFromApi()async{

    try{
      
      Response response =await http.get(Uri.parse(uri));
      print('1');
      if(response.statusCode==200){

        Map<String,dynamic> jsonResponse =jsonDecode(response.body);
        
        product =Products.fromJson(jsonResponse);
      }
      else{
        error = response.statusCode.toString();
      }

    }catch(e){
     
      error=e.toString();
       print(error);
    }
    isLoading = false;
    notifyListeners();

  }
}
