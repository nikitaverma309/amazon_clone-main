import 'package:flutter/material.dart';

import '../../../common/loader.dart';
import '../../../models/product.dart';
import '../services/admin_services.dart';
import '../widgets/admin_product_card.dart';
import 'add_product_screen.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
   List<Product>? products;
   final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  fetchAllProducts() async {
     products = await adminServices.fetchAllProducts(context :context);
    setState(() {});
  }

  void deleteProduct(Product product, int index) {
    adminServices.deleteProduct(
      context: context,
      product: product,
      onSuccess: () {
        products!.removeAt(index);
        setState(() {});
      },
    );
  }

  void navigateToAddProduct() {
    Navigator.pushNamed(context, AddProductScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return
      products == null
        ? const Loader()
        :
    Scaffold(
            body: GridView.builder(
              padding: EdgeInsets.only(bottom: 30),
              itemCount: products!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,childAspectRatio: 2/3),
              itemBuilder: (context, index) {
                final productData = products![index];
                return AdminProductCard(product:products![index] ,onDelete: (){ deleteProduct(productData, index);},);

              },
            ),
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: navigateToAddProduct,
              tooltip: 'Add a Product',
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }


}
