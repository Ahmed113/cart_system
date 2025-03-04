abstract class GetQuantityState{}
class GetQuantityInitState extends GetQuantityState{}
class GetQuantityLoadingState extends GetQuantityState{}
class GetQuantitySuccessState extends GetQuantityState{
  final int itemCount;
  final String id;
  GetQuantitySuccessState({required this.id, required this.itemCount});
}
class GetQuantityFailedState extends GetQuantityState{
  final String message;
  GetQuantityFailedState({required this.message});
}