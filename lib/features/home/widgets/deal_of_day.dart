
import 'package:amazon_clone/constatns/utils.dart';
import 'package:flutter/material.dart';

import '../../../common/loader.dart';
import '../../../models/product.dart';
import '../../product_details/screens/product_details_screen.dart';
import '../services/home_services.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({Key? key}) : super(key: key);

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  Product? product;
  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    fetchDealOfDay();
  }

  void fetchDealOfDay() async {
   product = await homeServices.fetchDealOfDay(context: context);
    setState(() {});
  }

  void navigateToDetailScreen() {
    Navigator.pushNamed(
      context,
      ProductDetailScreen.routeName,
      arguments: product,
    );
  }

  @override
  Widget build(BuildContext context) {
    return
      product == null
        ? const Loader()
        : product!.name.isEmpty
            ? const SizedBox()
            :
    GestureDetector(
                onTap: navigateToDetailScreen,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(left: 10, top: 15),
                      child: const Text(
                        'Deal of the day',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Image.network(
                       product!.images[0],
                      height: 235,
                      fit: BoxFit.fitHeight,
                    ),

                    SizedBox(height: 10,),
                    Container(
                      padding: const EdgeInsets.only(left: 15),
                      alignment: Alignment.topLeft,
                      child:  Text(
                        getPrice(price:  product!.price),
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding:
                          const EdgeInsets.only(left: 15, top: 5, right: 40),
                      child:  Text(
                        product!.name.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                     ),
                    SizedBox(height: 10,),

                    Container(height: 1,color: Colors.grey.withOpacity(.15),),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:product!.images
                            .map(
                              (item) => Row(
                                children: [
                                  Image.network(

                                    item,
                                    fit: BoxFit.fitWidth,
                                    width: 120,
                                    height: 100,
                                  ),
                                  Container(width: 1,height: 100,color: Colors.grey.withOpacity(.15),)
                                ],
                              ),
                            )
                            .toList(),


                      ),
                    ),
                    Container(height: 1,color: Colors.grey.withOpacity(.15),),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                      ).copyWith(left: 15),
                      alignment: Alignment.topLeft,
                      child: Text(
                        'See all deals',
                        style: TextStyle(
                          color: Colors.cyan[800],
                        ),
                      ),
                    ),
                  ],
                ),
              );
  }
}
