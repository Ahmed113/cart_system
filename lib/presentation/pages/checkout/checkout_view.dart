import 'package:cart_system/presentation/pages/checkout/cubit/promo_code_cubit.dart';
import 'package:cart_system/presentation/pages/checkout/cubit/promo_code_state.dart';
import 'package:cart_system/presentation/resources/colors_manager.dart';
import 'package:cart_system/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../resources/strings_manager.dart';



/// here's checkout bottom sheet that contains text field and bill container
/// that shows items and total price and price after discount
class CheckoutView extends StatelessWidget {
  final double totalPrice;
  final int itemsCount;

  CheckoutView({super.key, required this.itemsCount, required this.totalPrice});

  final TextEditingController _promoCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.all(AppPadding.p16),
            child: Column(
              spacing: 10,
              children: [
                TextFormField(
                  onFieldSubmitted: (value) {
                    if (value.trim().isNotEmpty) {
                      context.read<PromoCodeCubit>().getDiscount(
                        value.trim(),
                        totalPrice,
                      );
                    }
                  },
                  controller: _promoCodeController,
                  decoration: InputDecoration(
                    hintText: StringsManager.havePromoCode,
                    hintStyle: Theme.of(context).textTheme.titleMedium
                        ?.copyWith(color: ColorsManager.grey),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(AppPadding.p8),
                      child: Container(
                        decoration: BoxDecoration(
                          color: ColorsManager.blue,
                          borderRadius: BorderRadius.circular(AppSizes.s8),
                        ),
                        child: TextButton(
                          onPressed: () {
                            context.read<PromoCodeCubit>().getDiscount(
                              _promoCodeController.text.trim(),
                              totalPrice,
                            );
                          },
                          child: Text(
                            StringsManager.apply,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: ColorsManager.primary),
                          ),
                        ),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(AppSizes.s8),
                      ),
                      borderSide: BorderSide(width: AppSizes.s1),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(AppSizes.s8),
                      ),
                      borderSide: BorderSide(width: AppSizes.s1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(AppSizes.s8),
                      ),
                      borderSide: BorderSide(width: AppSizes.s1),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(AppSizes.s8),
                      ),
                      borderSide: BorderSide(
                        width: AppSizes.s1,
                        color: ColorsManager.red,
                      ),
                    ),
                    // filled: true,
                    // fillColor: ColorsManager.fieldColor,
                  ),
                  textAlign: TextAlign.start,
                ),
                Container(
                  padding: EdgeInsets.all(AppPadding.p16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppPadding.p8),
                    border: Border.all(
                      color: ColorsManager.grey,
                      width: AppSizes.s1_5,
                    ),
                  ),
                  child: Column(
                    spacing: AppSizes.s16,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            StringsManager.items,
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(color: ColorsManager.grey),
                          ),
                          Spacer(flex: 1),
                          Text(
                            '$itemsCount',
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(color: ColorsManager.grey),
                          ),
                        ],
                      ),
                      BlocBuilder<PromoCodeCubit, PromoCodeState>(
                        builder: (BuildContext context, PromoCodeState state) {
                          print("${state.runtimeType}");
                          switch (state.runtimeType) {
                            case PromoCodeLoadingState:
                              return CircularProgressIndicator();
                            case PromoCodeSuccessState:
                              return Column(
                                spacing: AppPadding.p16,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        StringsManager.totalPrice,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.labelMedium?.copyWith(
                                          color: ColorsManager.grey,
                                        ),
                                      ),
                                      Spacer(flex: 1),
                                      Text(
                                        '$totalPrice',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.labelMedium?.copyWith(
                                          color: ColorsManager.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        StringsManager.priceAfterDiscount,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.labelMedium?.copyWith(
                                          color: ColorsManager.grey,
                                        ),
                                      ),
                                      Spacer(flex: 1),
                                      Text(
                                        '${(state as PromoCodeSuccessState).priceAfterDiscount}',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.labelMedium?.copyWith(
                                          color: ColorsManager.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            default:
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    StringsManager.totalPrice,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        ?.copyWith(color: ColorsManager.grey),
                                  ),
                                  Spacer(flex: 1),
                                  Text(
                                    '$totalPrice',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        ?.copyWith(color: ColorsManager.grey),
                                  ),
                                ],
                              );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
