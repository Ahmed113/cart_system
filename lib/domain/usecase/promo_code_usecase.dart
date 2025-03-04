import 'package:cart_system/app/failure.dart';
import 'package:cart_system/domain/entity/promo_code.dart';
import 'package:cart_system/domain/repo/promo_code_repo.dart';
import 'package:cart_system/presentation/resources/strings_manager.dart';
import 'package:dartz/dartz.dart';

class PromoCodeUsecase{
  final PromoCodeRepo _promoCodeRepo;
  PromoCodeUsecase(this._promoCodeRepo);

  Future<Either<Failure, double>> getDiscount(String code, double totalPrice) async{
    try{
      List<PromoCode> promoCodes = await _promoCodeRepo.getPromoCodes();
      if (promoCodes.isNotEmpty) {
        for (var promoCode in promoCodes) {
          if (promoCode.code == code) {
            double price = totalPrice - (totalPrice * (promoCode.discountPercentage / 100));
            return Right(price.roundToDouble());
          }
        }
      }
      return Left(UnknownFailure(message: StringsManager.noOffers));
    }catch (e){
      return Left(UnknownFailure(message: e.runtimeType.toString()));
    }
  }
}