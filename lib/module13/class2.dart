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
  bool isloading =  false;

  List <dynamic> Products = [];
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      productcontroller.fetchProducts();
    });
  }
  // Future <void> loadProduct()async{
  //   try{
  //     setState(() {
  //       isloading = true;
  //     });
  //     await productcontroller.fetchProducts();
  //     if(!mounted)
  //       {
  //         return;
  //       }
  //     setState(() {
  //     });
  //   }catch(err)
  //   {
  //     ScaffoldMessenger.of(context).
  //     showSnackBar(SnackBar(
  //         content: Text(err.toString()
  //         )));
  //   }finally{
  //     setState(() {
  //       isloading = false;
  //     });
  //   }
  // }
  //
  //floating action button function;
  void productDialog()
  {
    TextEditingController productNameController = TextEditingController();
    TextEditingController productQTYController = TextEditingController();
    TextEditingController productImageController = TextEditingController();
    TextEditingController productUnitPriceController = TextEditingController();
    TextEditingController productTotalPriceController = TextEditingController();
  showDialog(context: context, builder:(context)=>
    AlertDialog(
      title: Text('Add product'),
      content: Column(
        mainAxisSize:MainAxisSize.min ,
        children: [
          TextField(
            decoration: InputDecoration(labelText: 'Product name'),
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Product Image'),
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Product qty'),
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Product unit price'),
          ),
          TextField(
            decoration: InputDecoration(labelText: 'total price'),
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(onPressed: (){
                Navigator.pop(context);
              }, child:Text('Close')),
              SizedBox(width: 5,),
              TextButton(onPressed: (){},

                  child:Text('Add Product')),
            ],
          )

        ],
      ),
    )
  );
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
                    onDelete: () {
                      productDialog();
                    },
                    onEdit: () {},
                    product: productcontroller.Prdoducts[index],);
                }),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan,
        onPressed: ()=>productDialog(),
      child: Icon(Icons.add,color: Colors.white,),
      ),
    );

  }
}
