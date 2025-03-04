import 'package:cart_system/app/failure.dart';
import 'package:cart_system/data/data_source/product_local_data_source.dart';
import 'package:cart_system/data/mappers/mapper.dart';
import 'package:cart_system/data/response/product_response/product_response.dart';
import 'package:cart_system/domain/repo/products_repo.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entity/product.dart';


class ProductsRepoImpl implements ProductsRepo{
  final ProductLocalDataSource _localDataSource;
  ProductsRepoImpl(this._localDataSource);

  @override
  Future<Either<Failure, List<Product>>> getProducts() async{
    try{
      List<ProductResponse> productsResponse = await _localDataSource.getProducts();
      List<Product> products = productsResponse.map((item) => item.toDomain()).toList();
      return Right(products);
    } catch (e) {
      return Left(LocalStorageFailure(message: e.toString()));
    }
  }
}