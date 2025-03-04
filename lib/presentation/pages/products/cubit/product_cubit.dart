import 'package:cart_system/domain/usecase/get_products_usecase.dart';
import 'package:cart_system/presentation/pages/products/cubit/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCubit extends Cubit<ProductState> {
  final GetProductsUsecase _getProductsUsecase;
  ProductCubit(this._getProductsUsecase) : super(ProductInitState());

  Future<void> getProducts() async{
    emit(ProductLoadingState());
    (await _getProductsUsecase.getProducts()).fold(
        (failure) => emit(ProductFailedState(message: failure.message)),
        (products) => emit(ProductSuccessState(products: products))
    );
  }
}