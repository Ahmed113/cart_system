import 'package:cart_system/presentation/pages/cart/cubit/get_cart/get_cart_cubit.dart';
import 'package:cart_system/presentation/resources/colors_manager.dart';
import 'package:cart_system/presentation/resources/strings_manager.dart';
import 'package:cart_system/presentation/resources/values_manager.dart';
import 'package:cart_system/presentation/shared_cubits/get_quantity/get_quantity_state.dart';
import 'package:cart_system/presentation/shared_widgets/add_delete_item_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entity/cart_item.dart';
import '../../../shared_cubits/get_quantity/get_quantity_cubit.dart';
import '../../../utility/show_snack_bar.dart';


/// cart item is an product with the added quantity from the user
class CartViewItem extends StatelessWidget {
  final CartItem cartItem;
  final int index;
  const CartViewItem({super.key, required this.cartItem, required this.index});

  @override
  Widget build(BuildContext context) {
    /// if any rebuilds in the cart item happens
    /// we need to make sure that we have the latest quantity of it
    context.read<GetQuantityCubit>().getQuantity(cartItem.id);
    return Container(
      padding: EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
        color: ColorsManager.primary,
        borderRadius: BorderRadius.all(Radius.circular(AppSizes.s8)),
        border: Border.all(color: ColorsManager.black, width: AppSizes.s1),
      ),
      child: Row(
        spacing: AppSizes.s8,
        children: [
          Column(
            spacing: AppSizes.s8,
            children: [
              Image.network(
                cartItem.product.imageUrl,
                height: AppSizes.s180,
                width: AppSizes.s120,
                fit: BoxFit.fill,
                errorBuilder: (context, error, stackTrace){
                  return Image.asset(StringsManager.defaultImg, height: AppSizes.s180,);
                },
              ),
              Text('${cartItem.product.price}\t${StringsManager.egyptianCurrency}',
                style: Theme.of(context).textTheme.bodyMedium,),
            ],
          ),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(cartItem.product.name, textAlign: TextAlign.start, style: Theme.of(context).textTheme.titleMedium,),
                /// here is the bloc consumer to manage the state of quantity item
                /// through builder we get the state if it loading or quantity retrieved
                /// if failure happen the failure message will appear through listener
                /// we handled build when to make sure that we doing changes on the targeted item
                BlocConsumer<GetQuantityCubit, GetQuantityState>(
                  buildWhen: (previous, current) {
                    if (current is GetQuantitySuccessState &&
                        (current).id == cartItem.id || current is GetQuantityLoadingState) {
                      return true;
                    }
                    return false;
                  },
                  listener: (BuildContext context, state) {
                    if (state is GetQuantityFailedState) {
                      showSnackBar(context, state.message);
                    }else if (state is GetQuantitySuccessState) {
                      context.read<GetCartCubit>().getCartItems();
                      // context.read<GetQuantityCubit>().getQuantity(cartItem.id);
                    }
                  },
                  builder: (BuildContext context, GetQuantityState quantityState) {
                    if (quantityState is GetQuantityLoadingState) {
                      return CircularProgressIndicator();
                    } else if (quantityState is GetQuantitySuccessState) {
                      return AddDeleteItemRow(product: cartItem.product, itemCount: quantityState.itemCount);
                    }
                    return Text(StringsManager.data);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
