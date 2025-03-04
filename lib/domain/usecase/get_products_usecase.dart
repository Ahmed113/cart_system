import 'package:cart_system/domain/repo/products_repo.dart';
import 'package:dartz/dartz.dart';

import '../../app/failure.dart';
import '../entity/product.dart';

class GetProductsUsecase{
  final ProductsRepo _productsRepo;
  GetProductsUsecase(this._productsRepo);

  Future<Either<Failure, List<Product>>> getProducts() async{
    return await _productsRepo.getProducts();
  }
}