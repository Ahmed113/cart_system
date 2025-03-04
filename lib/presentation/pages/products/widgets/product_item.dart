import 'package:cart_system/presentation/resources/strings_manager.dart';
import 'package:cart_system/presentation/resources/values_manager.dart';
import 'package:cart_system/presentation/shared_widgets/add_delete_item_row.dart';
import 'package:cart_system/presentation/utility/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../domain/entity/product.dart';
import '../../../shared_cubits/get_quantity/get_quantity_cubit.dart';
import '../../../shared_cubits/get_quantity/get_quantity_state.dart';
import 'add_to_cart_card.dart';


/// here's product item that shows product data like image and name
/// and also show if it has been added to cart or not with the latest quantity
/// also the user can add or delete it
class ProductItem extends StatefulWidget {
  final Product product;

  const ProductItem({
    super.key,
    required this.product,
    // required this.index
  });

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {

  /// once the product screen opens we need to
  /// get the latest state of item's quantity if its added before of not and how many times added
  @override
  void initState() {
    context.read<GetQuantityCubit>().getQuantity(widget.product.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppPadding.p8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(AppSizes.s8)),
        border: Border.all(color: Colors.black12, width: AppSizes.s1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // spacing: 8,
        children: [
          /// product image from network with default image if the internet connection failed
          Image.network(
            widget.product.imageUrl,
            height: AppSizes.s180,
            width: AppSizes.s100,
            fit: BoxFit.fill,
            errorBuilder: (context, error, stackTrace){
              return Image.asset(StringsManager.defaultImg, height: AppSizes.s180, width: AppSizes.s100,);
            },
          ),
          Text(widget.product.name, maxLines: 2, style: Theme.of(context).textTheme.titleSmall,),
          Align(
            alignment: Alignment.centerRight,
            /// bloc to change quantity state after calling getQuantity above
            child: BlocConsumer<GetQuantityCubit, GetQuantityState>(
              buildWhen: (previous, current) {
                if (current is GetQuantitySuccessState &&
                    (current).id == widget.product.id || current is GetQuantityLoadingState) {
                  return true;
                }
                return false;
              },
              listener: (BuildContext context, state) {
                if (state is GetQuantityFailedState) {
                  showSnackBar(context, state.message);
                }
              },
              builder: (BuildContext context, GetQuantityState state) {
                if (state is GetQuantityLoadingState) {
                  return CircularProgressIndicator();
                } else if (state is GetQuantitySuccessState) {
                  /// in success state we will return card view in product item that doesn't
                  /// added and return the quantity with add and delete icons if it's added
                  return state.itemCount == 0
                      ? AddToCartCard(product: widget.product)
                      : AddDeleteItemRow(product: widget.product, itemCount: state.itemCount);
                }
                return AddToCartCard(product: widget.product);
              },
            ),
          ),
        ],
      ),
    );
  }
}
