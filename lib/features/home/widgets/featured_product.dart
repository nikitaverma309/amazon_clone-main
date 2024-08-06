import 'package:amazon_clone/features/home/services/home_services.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/cupertino.dart';

import 'freatured_product_card.dart';

class FeaturedProduct extends StatefulWidget {
  const FeaturedProduct({Key? key}) : super(key: key);

  @override
  State<FeaturedProduct> createState() => _FeaturedProductState();
}

class _FeaturedProductState extends State<FeaturedProduct> {
  List<Product> productList = [];
  bool isLoading = false;

  @override
  void initState() {
    initData();
    super.initState();
  }

  initData() async {
    setState(() {
      isLoading = true;
    });
    productList = await HomeServices().fetchAllProducts(
      context: context,
    );

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 12),
          child: Text(
            "Featured Products",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.only(bottom: 10),
          itemCount: productList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 2 / 3),
          itemBuilder: (context, index) {
            return FeaturedProductCard(
              product: productList[index],
            );
          },
        ),
      ],
    );
  }
}
