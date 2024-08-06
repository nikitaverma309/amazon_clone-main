

import 'package:amazon_clone/features/product_details/screens/product_details_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../constatns/utils.dart';
import '../../../models/product.dart';

class FeaturedProductCard extends StatelessWidget {
  final Product product;

  const FeaturedProductCard(
      {Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.withOpacity(.2), width: .8)),
      child:

          InkWell(
            onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (builder)=>ProductDetailScreen(product: product))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: CachedNetworkImage(
                    imageUrl: product.images[0],
                    fit: BoxFit.fill,
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey,
                      highlightColor: Colors.white,
                      child: Container(
                        height: 500,
                        width: 500,
                        color: Colors.black.withOpacity(.2),
                      ),
                    ),
                  ),
                ),
                Container(height: .8,color: Colors.grey.withOpacity(.2),),
                Expanded(
                  child:
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        SizedBox(height: 6,),

                        Text(
                          getPrice(price: product.price),
                          style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black.withOpacity(.8),fontSize: 15),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        SizedBox(height: 2,),
                        Text(
                          product.name,
                          style: TextStyle(fontWeight: FontWeight.w400,color: Colors.black.withOpacity(.8),fontSize: 14),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),


    );
  }
}
