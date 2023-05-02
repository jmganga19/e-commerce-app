import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/gridmap.dart';
import '../constants/pallete.dart';
import '../providers/product_provider.dart';
import '../providers/user_provider.dart';
import '../widgets/category_widget.dart';
import '../widgets/product_Card.dart';
import 'details.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final serchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
  final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 23),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Text('Hi,${userProvider.userModel?.name ?? "..."} 🖐',
                      style: TextStyle(
                          fontFamily: 'Cera Pro',
                          fontSize: 24,
                          fontWeight: FontWeight.bold)),
                  Container(
                    height: 50,
                    width: 50,
                    //margin: const EdgeInsets.only(top: 4),
                    decoration: const BoxDecoration(
                      color: Pallete.greyColor,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage('assets/images/profile.jpg')),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              const Text('Match Your Style',
                  style: TextStyle(
                      color: Pallete.blackColor,
                      fontFamily: 'Cera Pro',
                      fontSize: 18,
                      fontWeight: FontWeight.normal)),
              const SizedBox(
                height: 15,
              ),
              Container(
                  width: 353,
                  height: 45,
                  decoration: BoxDecoration(
                      color: Pallete.whiteColor,
                      borderRadius: BorderRadius.circular(40)),
                  child: TextField(
                    controller: serchController,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search,
                            size: 24, color: Pallete.greyFont),
                        hintText: 'Search',
                        hintStyle: TextStyle(
                            fontFamily: 'Cera Pro',
                            fontSize: 18,
                            color: Pallete.greyFont),
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none),
                  )),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: CategoryWidget(
                        categoryName: 'Trending Now',
                        isSelected: true,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: CategoryWidget(
                        categoryName: 'All Products',
                        isSelected: false,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: CategoryWidget(
                        categoryName: 'New Products',
                        isSelected: false,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 500,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    mainAxisExtent: 280,
                  ),
                  itemCount: productProvider.products.length,
                  itemBuilder: (context, index) {
                    var product = productProvider.products[index];
                    return ProductCard(product: product);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
