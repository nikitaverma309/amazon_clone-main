import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../constatns/global_varibales.dart';

class CarouselImage extends StatefulWidget {
  const CarouselImage({Key? key}) : super(key: key);

  @override
  State<CarouselImage> createState() => _CarouselImageState();
}

class _CarouselImageState extends State<CarouselImage> {
  int carouselIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemBuilder: ((context, index, _) {
        return Stack(
          fit: StackFit.expand,
          alignment: Alignment.bottomCenter,
          children: [
            CachedNetworkImage(
              imageUrl: GlobalVariables.carouselImages[carouselIndex],
              fit: BoxFit.fill,
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey,
                highlightColor: Colors.white,
                child: Container(
                  height: 200,
                  color: Colors.black.withOpacity(.2),
                ),
              ),
            ),
            Positioned(
              child: AnimatedSmoothIndicator(
                activeIndex: carouselIndex,
                count: GlobalVariables.carouselImages.length,
                effect: WormEffect(dotHeight: 5,dotWidth: 12,dotColor: Colors.white,activeDotColor: GlobalVariables.secondaryColor),
              ),

              bottom: 10,
            )
          ],
        );
      }),
      options: CarouselOptions(
        onPageChanged: (index, _) {
          setState(() {
            carouselIndex = index;
          });
        },
        viewportFraction: 1,
        height: 200,
      ),
      itemCount: GlobalVariables.carouselImages.length,
    );
  }
}
