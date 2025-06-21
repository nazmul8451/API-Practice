import 'dart:convert';
import 'package:api/utils/urls.dart';
import 'package:http/http.dart'as http;
import 'models/productModel.dart';

class ProductController{
  List<Data>Prdoducts = [];
//------------------------------------------------------
  Future<void> fetchProducts() async{
    final response = await http.get(Uri.parse(Urls.readProduct));
    print(response.statusCode);

    if(response.statusCode == 200)
      {
        final data = jsonDecode(response.body);
        ProductModel model = ProductModel.fromJson(data);
        Prdoducts = model.data??[];
      }else{
      throw Exception('Failed to load products');
    }
  }
//------------------------------------------------------
}

