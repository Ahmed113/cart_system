import 'package:cart_system/app/di.dart';
import 'package:cart_system/presentation/pages/cart/cubit/get_cart/get_cart_cubit.dart';
import 'package:cart_system/presentation/pages/cart/cubit/get_cart/get_cart_state.dart';
import 'package:cart_system/presentation/pages/cart/widgets/cart_view_item.dart';
import 'package:cart_system/presentation/pages/checkout/checkout_view.dart';
import 'package:cart_system/presentation/pages/checkout/cubit/promo_code_cubit.dart';
import 'package:cart_system/presentation/resources/colors_manager.dart';
import 'package:cart_system/presentation/resources/fonts_manager.dart';
import 'package:cart_system/presentation/resources/strings_manager.dart';
import 'package:cart_system/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entity/cart_item.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.primary,

      /// cubit for retrieving cart items
      /// with 3 main states loading and success and failure
      body: BlocBuilder<GetCartCubit, GetCartState>(
        builder: (BuildContext context, GetCartState state) {
          switch (state.runtimeType) {
            /// loading state
            case GetCartLoadingState:
              return Center(child: CircularProgressIndicator());

            /// success state
            case GetCartSuccessState:
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      /// carts list
                      child: ListView.builder(
                        itemCount:
                            (state as GetCartSuccessState).cartItems.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          CartItem cartItem = state.cartItems[index];
                          return Padding(
                            padding: const EdgeInsets.all(AppPadding.p8),
                            child: CartViewItem(
                              cartItem: cartItem,
                              index: index,
                            ),
                          );
                        },
                      ),
                    ),
                    /// checkout container that has total price and items
                    /// it's clickable and open bottom sheet that has text field for promo codes
                    Padding(
                      padding: const EdgeInsets.all(AppPadding.p8),
                      child: Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.all(AppPadding.p8),
                        decoration: BoxDecoration(
                          color: ColorsManager.blue,
                          borderRadius: BorderRadius.all(
                            Radius.circular(AppSizes.s8),
                          ),
                        ),
                        child: InkWell(
                          onTap: () {
                            /// bottom sheet for checkout
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              useSafeArea: true,
                              builder: (context) {
                                promoCodeModule();
                                return BlocProvider(
                                  create:
                                      (context) => instance<PromoCodeCubit>(),
                                  child: CheckoutView(
                                    itemsCount: state.totalItems,
                                    totalPrice: state.totalPrice,
                                  ),
                                );
                              },
                            );
                          },
                          /// row to show the items data in right side and the other it's checkout text with icon
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            spacing: AppSizes.s8,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                // mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '${state.totalItems} ${StringsManager.items}',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleSmall?.copyWith(
                                      color: ColorsManager.primary,
                                    ),
                                  ),
                                  Text(
                                    '${state.totalPrice} ${StringsManager.egyptianCurrency}',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.labelMedium?.copyWith(
                                      color: ColorsManager.primary,
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(flex: 1),
                              Text(
                                StringsManager.checkout,
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(color: ColorsManager.primary),
                              ),
                              Icon(
                                Icons.exit_to_app,
                                size: FontSize.s32,
                                color: ColorsManager.primary,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );

            /// failure state
            case GetCartFailedState:
              return Text((state as GetCartFailedState).message);
            default:
              return SizedBox();
          }
        },
      ),
    );
  }
}
