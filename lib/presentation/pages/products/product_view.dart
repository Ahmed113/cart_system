import 'package:cart_system/presentation/pages/products/cubit/product_cubit.dart';
import 'package:cart_system/presentation/pages/products/cubit/product_state.dart';
import 'package:cart_system/presentation/pages/products/widgets/product_item.dart';
import 'package:cart_system/presentation/resources/colors_manager.dart';
import 'package:cart_system/presentation/resources/strings_manager.dart';
import 'package:cart_system/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entity/product.dart';

/// here's product screen that show all products in grid view
class ProductView extends StatelessWidget {
  const ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.primary,
      body: Container(
        padding: EdgeInsets.all(AppPadding.p16),
        child: Column(
          children: [
            /// bloc to manage state of retrieving products
            BlocBuilder<ProductCubit, ProductState>(
              builder: (BuildContext context, ProductState state) {
                switch(state.runtimeType) {
                  case ProductInitState:
                    return SizedBox();
                  case ProductLoadingState:
                    return Center(child: CircularProgressIndicator());
                  case ProductSuccessState:
                    /// products gridview in success state
                    return Expanded(
                      child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // Number of items per row
                            crossAxisSpacing: AppSizes.s10, // Space between columns
                            mainAxisSpacing: AppSizes.s10, // Space between rows
                            childAspectRatio: .45,
                          ),
                          itemCount: (state as ProductSuccessState).products.length,
                          itemBuilder: (context, index){
                            Product product = state.products[index];
                            return ProductItem(product: product,);
                          },
                      ),
                    );
                  case ProductFailedState:
                    return Text((state as ProductFailedState).message);
                  default:
                    return Center(child: Text(StringsManager.productWillAppear, style: Theme.of(context).textTheme.labelLarge,));
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
