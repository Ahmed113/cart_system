import 'dart:convert';

import 'package:cart_system/data/response/product_response/product_response.dart';
import 'package:cart_system/presentation/resources/assets_manager.dart';
import 'package:flutter/services.dart';

abstract class ProductLocalDataSource{
  Future<List<ProductResponse>> getProducts();
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource{
  @override
  Future<List<ProductResponse>> getProducts() async{
    String jsonString = await rootBundle.loadString(AssetsManager.productsJson);
    List productsJsonList = jsonDecode(jsonString);
    List<ProductResponse> products = productsJsonList.map((productItem) => ProductResponse.fromJson(productItem)).toList();
    return products;
  }
}