import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../constatns/global_varibales.dart';
import '../services/product_details_services.dart';

class RateProductDialog extends StatefulWidget {
  final double star;
  final Product product;

  const RateProductDialog({Key? key, required this.star, required this.product})
      : super(key: key);

  @override
  State<RateProductDialog> createState() => _RateProductDialogState();
}

class _RateProductDialogState extends State<RateProductDialog> {
  double rating = 0.0;
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    rating = widget.star;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ProductDetailsServices productDetailsServices =
        ProductDetailsServices();
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 18,
            ),
            Text(
              "Product Review",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 24,
            ),
            RatingBar.builder(
              initialRating: widget.star,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: GlobalVariables.secondaryColor,
              ),
              onRatingUpdate: (res) {
                setState(() {
                  rating = res;
                });
              },
            ),
            SizedBox(
              height: 22,
            ),
            TextField(
                controller: _controller,
                decoration: InputDecoration(
                    hintText: "Write Review", border: OutlineInputBorder()),
                maxLines: 5),
            SizedBox(
              height: 24,
            ),
            Row(
              children: [
                Spacer(),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "CANCEL",
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.w500),
                    )),
                TextButton(
                    onPressed: () {
                      productDetailsServices.rateProduct(
                          context: context,
                          rating: rating,
                          review: _controller.text,
                          product: widget.product);
                    },
                    child: Text(
                      "SUBMIT",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    )),
              ],
            ),
            SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}
