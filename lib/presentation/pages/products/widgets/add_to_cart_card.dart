import 'package:cart_system/data/mappers/mapper.dart';
import 'package:cart_system/presentation/resources/colors_manager.dart';
import 'package:cart_system/presentation/resources/strings_manager.dart';
import 'package:cart_system/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entity/product.dart';
import '../../../shared_cubits/add_to_cart/add_to_cart_cubit.dart';
import '../../../shared_cubits/get_quantity/get_quantity_cubit.dart';


/// card view in the product item in case not added to cart
class AddToCartCard extends StatelessWidget {
  const AddToCartCard({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        context.read<AddToCartCubit>().addToCart(product.toCartItem());
        context.read<GetQuantityCubit>().getQuantity(product.id);
      },
      child: Card(
        color: ColorsManager.primary,
        elevation: AppSizes.s4,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(AppSizes.s8))
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.add_shopping_cart, size: AppSizes.s20,),
              Text(StringsManager.addToCart, style: Theme.of(context).textTheme.bodyMedium,),
            ],
          ),
        ),
      ),
    );
  }
}