import 'package:dartz/dartz.dart';

import '../../app/failure.dart';
import '../entity/product.dart';

abstract class ProductsRepo{
  Future<Either<Failure, List<Product>>> getProducts();
}