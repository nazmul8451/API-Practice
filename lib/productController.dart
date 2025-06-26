import 'dart:convert' show jsonDecode, jsonEncode;
import 'package:api/utils/urls.dart';
import 'package:http/http.dart'as http;
import 'models/productModel.dart';

class ProductController{
  List<Data> products = [];
//------------------------------------------------------
  Future<void> fetchProducts() async{
    final response = await http.get(Uri.parse(Urls.readProduct));
    print(response.statusCode);

    if(response.statusCode == 200)
      {
        final data = jsonDecode(response.body);
        ProductModel model = ProductModel.fromJson(data);
        products = model.data??[];
      }else{
      throw Exception('Failed to load products');
    }
  }
//------------------------------------------------------

  Future<void> createProducts(String productName,String img,int qty,String? ProductId, int UnitPrice,int totalPrice,bool isUpdate) async{
    final response = await http.post(Uri.parse(isUpdate?Urls.updateProduct(ProductId!):Urls.createProduct),
      headers: {'Content-Type':'application/json'},
        body: jsonEncode(
        {
        "ProductName": productName,
        "ProductCode":DateTime.now().microsecondsSinceEpoch,
        "Img": img,
        "Qty": qty,
        "UnitPrice":UnitPrice,
        "TotalPrice":totalPrice,
        }
    )
    );
    print(response.statusCode);

    if(response.statusCode == 201 || response.statusCode ==204)
    {
     await fetchProducts();
    }else{
      throw Exception('Failed to load products');
    }
  }

Future<bool> DeleteProducts(String productID)async{
    final response = await http.get(Uri.parse(Urls.deleteProduct(productID)));
    print(response.statusCode);
    if(response.statusCode == 200){
      fetchProducts();
      return true;
    }else{
      return false;
    }
}

}

