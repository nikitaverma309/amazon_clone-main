import 'dart:developer';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../../common/custom_button.dart';
import '../../../common/custom_textfield.dart';
import '../../../constatns/global_varibales.dart';
import '../../../constatns/utils.dart';
import '../services/admin_services.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = '/add-product';

  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  final AdminServices adminServices = AdminServices();

  String? category;

  List<File> images = [];
  final _addProductFormKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
  }

  List<String> productCategories = [
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
    'Fashion',
    'Other'
  ];

   sellProduct() async{
    if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
      setState(() {
        isLoading  = true;
      });
    await  adminServices.sellProduct(
        context: context,
        name: productNameController.text,
        description: descriptionController.text,
        price: double.parse(priceController.text),
        quantity: double.parse(quantityController.text),
        category: category ??"Other",
        images: images,
      );
      setState(() {
        isLoading  = false;
      });
    }
  }

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(left: 16, right: 16, bottom: 12, top: 8),
        child: ElevatedButton(
          child:isLoading?  CircularProgressIndicator(color: Colors.black,strokeWidth: 2,): const Text( 'Sell Product',style: TextStyle(color: Colors.black),),
          onPressed: sellProduct,
          style: ElevatedButton.styleFrom(minimumSize: Size(50,50)),
        ),
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: GlobalVariables.appBarGradient(opacity: .2),
            ),
          ),
          title: const Text(
            'Add Product',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _addProductFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                images.isNotEmpty
                    ? CarouselSlider(
                        items: images.map(
                          (i) {
                            return Builder(
                              builder: (BuildContext context) => Image.file(
                                i,
                                fit: BoxFit.cover,
                                height: 200,
                              ),
                            );
                          },
                        ).toList(),
                        options: CarouselOptions(
                          viewportFraction: 1,
                          height: 200,
                        ),
                      )
                    : GestureDetector(
                        onTap: selectImages,
                        child: DottedBorder(
                          color: Colors.black54,
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(10),
                          dashPattern: const [10, 4],
                          strokeCap: StrokeCap.round,
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.folder_open,
                                  size: 40,
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  'Select Product Images',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                const SizedBox(height: 30),
                CustomTextField(
                  controller: productNameController,
                  hintText: 'Product Name',
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: descriptionController,
                  hintText: 'Description',
                  maxLines: 7,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  inputType: TextInputType.number,
                  controller: priceController,
                  hintText: 'Price',
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  inputType: TextInputType.number,
                  controller: quantityController,
                  hintText: 'Quantity',
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: InkWell(
                    onTap: () async{
                    String? val = await showModalBottomSheet(
                          context: context,
                          builder: (builder) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [

                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 18),
                                  child: Row(
                                    children: [
                                      const Text(
                                        "Select Product Category",
                                        style: TextStyle(
                                            color: Colors.black87, fontSize: 18,fontWeight: FontWeight.w500),
                                      ),
                                      Spacer(),
                                      InkWell(
                                        onTap: (){
                                          Navigator.of(context).pop();
                                        },
                                        child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 4,vertical: 16),
                                          child: Icon(Icons.close_outlined)),)
                                    ],
                                  ),
                                ),

                                Container(height: 1,color: Colors.black.withOpacity(.1),),
                                SizedBox(height: 4,),
                                ...productCategories.map((e) => InkWell(
                                  onTap: (){
                                    Navigator.pop(context, e);
                                  },
                                        child: Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 16,vertical: 12),
                                            child: Text(e.toString(),style: TextStyle(
                                              fontSize: 16
                                            ),)),
                                      ],
                                    ))),
                                SizedBox(height: 12,),
                              ],
                            );
                          });

                    if(val != null){
                      setState(() {
                          category = val;
                        });
                      }

                    },
                    child: Container(
                        height: 55,
                        padding: EdgeInsets.only(left: 8, right: 12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            border: Border.all(color: Colors.black38)),
                        child: Row(
                          children:  [
                        category == null ?    Text(
                          "Product Category",
                          style: TextStyle(
                              color: Colors.black54, fontSize: 15.5),
                        ):   Text(
                          category!,
                          style: TextStyle(
                              color: Colors.black87, fontSize: 16),
                        ),
                            Spacer(),
                            Icon(Icons.keyboard_arrow_down,color: Colors.black54,),
                          ],
                        )),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
