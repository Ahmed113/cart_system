import 'package:cart_system/data/mappers/mapper.dart';
import 'package:cart_system/presentation/resources/colors_manager.dart';
import 'package:cart_system/presentation/resources/values_manager.dart';
import 'package:cart_system/presentation/utility/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entity/product.dart';
import '../shared_cubits/add_to_cart/add_to_cart_cubit.dart';
import '../shared_cubits/add_to_cart/add_to_cart_state.dart';
import '../shared_cubits/delete_from_cart/delete_from_cart_cubit.dart';
import '../shared_cubits/delete_from_cart/delete_from_cart_state.dart';
import '../shared_cubits/get_quantity/get_quantity_cubit.dart';


/// here's the row that handles adding and removing items from the cart
/// or from the product screen
/// it contains icon '-' for removing and number of quantity and '+' for adding
class AddDeleteItemRow extends StatelessWidget {
  const AddDeleteItemRow({super.key, required this.product, required this.itemCount,});

  final Product product;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: AppSizes.s4,
      children: [
        /// here's blc consumer for removing item so it decrease quantity by 1 in each click
        /// if it is 0 the item will be removed from cart
        /// it's used in cart and products screen
        BlocConsumer<DeleteFromCartCubit, DeleteFromCartState>(
          buildWhen: (previous, current) {
            if (current is DeleteFromCartSuccessState &&
                (current).id == product.id) {
              return true;
            }
            return false;
          },
          listener: (BuildContext context, DeleteFromCartState state) {
            if (state is DeleteFromCartFailedState) {
              showSnackBar(context, state.message);
            }else if (state is DeleteFromCartSuccessState) {
              /// after deleting success we call getQuantity method that will change the quantity state to get the latest
              context.read<GetQuantityCubit>().getQuantity(product.id);
            }
          },
          builder: (context, state) {
            if (state is DeleteFromCartLoadingState) {
              return CircularProgressIndicator();
            }
            return IconButton(
              onPressed: (){
                /// delete begin from here once the remove icon clicked
                context.read<DeleteFromCartCubit>().deleteFromCart(product.toCartItem());
              },
              icon: Icon(Icons.remove, color: ColorsManager.red),
            );
          },
        ),

        /// here the returned latest quantity number that we got from getQuantity method after each add or delete
        Text('$itemCount', style: Theme.of(context).textTheme.bodyMedium,),

        /// bloc consumer for add item quantity or add new items it works similarly the delete bloc above
        BlocConsumer<AddToCartCubit, AddToCartState>(
          buildWhen: (previous, current) {
            if (current is AddToCartSuccessState &&
                (current).id == product.id ||
                current is AddToCartLoadingState &&
                    (current).id == product.id) {
              return true;
            }
            return false;
          },
          listener: (BuildContext context, AddToCartState state) {
            if (state is AddToCartFailedState) {
              showSnackBar(context, state.message);
            } else if (state is AddToCartSuccessState) {
              /// we call getQuantity after each add
              context.read<GetQuantityCubit>().getQuantity(product.id);
            }
          },

          builder: (context, state) {
            if (state is AddToCartLoadingState) {
              return CircularProgressIndicator();
            }
            return IconButton(
              onPressed: () {
                /// adding begin from here once we click add icon
                context.read<AddToCartCubit>().addToCart(
                  product.toCartItem(),
                );
              },
              icon: Icon(Icons.add, color: ColorsManager.green),
            );
          },
        ),
      ],
    );
  }
}
