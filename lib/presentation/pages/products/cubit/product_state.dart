
import '../../../../domain/entity/product.dart';

abstract class ProductState{}
class ProductInitState extends ProductState{}
class ProductLoadingState extends ProductState{}
class ProductSuccessState extends ProductState{
  final List<Product> products;
  ProductSuccessState({required this.products});
}
class ProductFailedState extends ProductState{
  final String message;
  ProductFailedState({required this.message});
}
