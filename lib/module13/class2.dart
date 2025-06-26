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
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  Future<void> loadProducts() async {
    await productcontroller.fetchProducts();
    setState(() {}); // UI Rebuild after fetching data

    setState(() {
      isLoading = true;
    });
    await productcontroller.fetchProducts();
    setState(() {
      isLoading = false;
    });
  }


  void productDialog({String? id,String ? name,String? img,int? qty,int? unitPrice,int? totalPrice,required bool isUpdate}) {
    TextEditingController productNameController = TextEditingController();
    TextEditingController productQTYController = TextEditingController();
    TextEditingController productImageController = TextEditingController();
    TextEditingController productUnitPriceController = TextEditingController();
    TextEditingController productTotalPriceController = TextEditingController();

    productNameController.text = name??"";
    productImageController.text = img??"";
    productQTYController.text = qty != null ? qty.toString(): '0';
    productUnitPriceController.text = unitPrice != null ? unitPrice.toString(): '0';
    productTotalPriceController.text = totalPrice != null ? totalPrice.toString(): '0';

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(isUpdate?"Update Product":'Add product'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: productNameController,
                    decoration: InputDecoration(labelText: 'Product name'),
                  ),
                  TextField(
                    controller: productImageController,
                    decoration: InputDecoration(labelText: 'Product Image'),
                  ),
                  TextField(
                    controller: productQTYController,
                    decoration: InputDecoration(labelText: 'Product qty'),
                  ),
                  TextField(
                    controller: productUnitPriceController,
                    decoration:
                        InputDecoration(labelText: 'Product unit price'),
                  ),
                  TextField(
                    controller: productTotalPriceController,
                    decoration: InputDecoration(labelText: 'total price'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Close')),
                      SizedBox(
                        width: 5,
                      ),
                      TextButton(
                        onPressed: () async {
                          try {
                            if (id != null && isUpdate) {
                              await productcontroller.createProducts(
                                productNameController.text,
                                productImageController.text,
                                int.parse(productQTYController.text),
                                id,
                                int.parse(productUnitPriceController.text),
                                int.parse(productTotalPriceController.text.trim()),
                                true,
                              );
                            } else {
                              await productcontroller.createProducts(
                                productNameController.text,
                                productImageController.text,
                                int.parse(productQTYController.text),
                                null,
                                int.parse(productUnitPriceController.text),
                                int.parse(productTotalPriceController.text.trim()),
                                false,
                              );
                            }
                          } catch (e) {
                            print("Error: $e");
                          }

                          Navigator.of(context, rootNavigator: true).pop(); // এইটাই দরকার
                          await loadProducts();
                          setState(() {});
                        },
                        child: Text(isUpdate ? 'Update Product' : 'Add Product'),
                      ),

                    ],
                  )
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Product Create & Delete'),
        backgroundColor: Colors.cyan,
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : productcontroller.products.isEmpty
                      ? Center(child: Text('No Products Found'))
                      : GridView.builder(
                          padding: EdgeInsets.all(10),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                  childAspectRatio: 0.8,
                                  crossAxisCount: 2),
                          itemCount: productcontroller.products.length,
                          itemBuilder: (context, index) {
                            var prodcut = productcontroller.products[index];
                            return ProductCard(
                              onDelete: () {
                                productcontroller.DeleteProducts(prodcut.sId.toString())
                                    .then((value)async{
                                  if(value){
                                    await productcontroller.fetchProducts();
                                    setState(() {
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                          content:Text("Product Deleted"),
                                        duration: Duration(seconds: 2),
                                      ));
                                    });
                                  }else{
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                        content:Text('Something wrong..'),
                                    duration: Duration(seconds: 2),
                                    ));
                                  }

                                });
                              },
                              onEdit: () {
                                productDialog(
                                name:prodcut.productName,
                                  id:prodcut.sId ,
                                  img:prodcut.img ,
                                  qty: prodcut.qty,
                                  totalPrice: prodcut.totalPrice,
                                  unitPrice:prodcut.unitPrice,
                                  isUpdate: true,
                                );
                              },
                              product: prodcut,
                            );
                          }),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan,
        onPressed: () => productDialog(isUpdate: false),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
