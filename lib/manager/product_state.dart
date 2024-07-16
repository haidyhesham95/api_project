part of 'product_cubit.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}
final  class Success extends ProductState {}

final class Error extends ProductState {
  final String errorMessage;
  Error(this.errorMessage);
}