import 'package:api/productController.dart';
import 'package:flutter/material.dart';

import '../widgets/product_cardWidgets.dart';
class API_calling extends StatefulWidget {
  const API_calling({super.key});

  @override
  State<API_calling> createState() => _API_callingState();
}

class _API_callingState extends State<API_calling> {
  final ProductController productcontroller = ProductController();

  List <dynamic> Products = [];
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      productcontroller.fetchProducts();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Product Create & Delete'),
        backgroundColor: Colors.cyan,
      ),
      body:SafeArea(
        child: Column(
          children: [
            SizedBox(height: 10,),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.all(10),
                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio:0.8,
                    crossAxisCount: 2),
                itemCount: Products.length,
                itemBuilder: (context,index){
        
                  return  ProductCard(
                    onDelete: () {  },
                    onEdit: () {  }, product: productcontroller.Prdoducts[index],);
                }),
            )
          ],
        ),
      ),
    );

  }
}
