import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import 'package:http/http.dart' as http;
import '../model/model.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());


  static ProductCubit get(context) => BlocProvider.of<ProductCubit>(context);
  bool isLoading = true;

  bool isError = false;

  String errorMessage = '';

  List<ProductDataModel> myList = [];

  Future<void> getProductsData() async {
    emit(ProductLoading());
    try {
      var response = await http.get(Uri.parse('https://dummyjson.com/products'));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        List<dynamic> productsList = data['products'];
        for (Map<String, dynamic> item in productsList) {
          ProductDataModel productDataModel = ProductDataModel.fromMapJson(item);
          myList.add(productDataModel);
        }
        emit(Success());
      } else {
        emit(Error('Error ${response.statusCode}'));
      }
    } catch (e) {
      emit(Error('Error $e'));
    }
  }
}
