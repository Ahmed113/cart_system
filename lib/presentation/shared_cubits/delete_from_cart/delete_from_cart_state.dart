abstract class DeleteFromCartState{}
class DeleteFromCartInitState extends DeleteFromCartState{}
class DeleteFromCartLoadingState extends DeleteFromCartState{

}
class DeleteFromCartSuccessState extends DeleteFromCartState{
  final int itemCount;
  final String id;
  DeleteFromCartSuccessState({required this.itemCount, required this.id});
}
class DeleteFromCartFailedState extends DeleteFromCartState{
  final String message;
  DeleteFromCartFailedState({required this.message});
}