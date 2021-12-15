import 'package:flutter/material.dart';
import 'package:food_app/config/colors.dart';
import 'package:food_app/providers/product_provider.dart';
import 'package:food_app/providers/user_provider.dart';
import 'package:food_app/screens/product_overview/product_overview.dart';
import 'package:food_app/screens/home/single_product.dart';
import 'package:food_app/screens/review_cart/review_cart.dart';
import 'package:food_app/screens/search/search.dart';
import 'package:provider/provider.dart';
import 'drawer_side.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ProductProvider productProvider;

  Widget _buildHerbsProduct(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Coming Soon'),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Search(
                        search: productProvider.getComingSoonProductDataList,
                      ),
                    ),
                  );
                },
                child: Text(
                  'view all',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: productProvider.getComingSoonProductDataList.map(
              (comingSoonProduct) {
                return SingalProduct(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProductOverview(
                          productId: comingSoonProduct.productId,
                          productPrice: comingSoonProduct.productPrice,
                          productName: comingSoonProduct.productName,
                          productImage: comingSoonProduct.productImage,
                        ),
                      ),
                    );
                  },
                  productId: comingSoonProduct.productId,
                  productPrice: comingSoonProduct.productPrice,
                  productImage: comingSoonProduct.productImage,
                  productName: comingSoonProduct.productName,
                  productUnit:comingSoonProduct ,
                );
              },
            ).toList(),
            // children: [

            // ],
          ),
        ),
      ],
    );
  }

  Widget _buildFreshProduct(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Recently launched'),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Search(
                        search: productProvider.getFreshProductDataList,
                      ),
                    ),
                  );
                },
                child: Text(
                  'view all',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: productProvider.getFreshProductDataList.map(
              (freshProductData) {
                return SingalProduct(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProductOverview(
                          productId: freshProductData.productId,
                          productImage: freshProductData.productImage,
                          productName: freshProductData.productName,
                          productPrice: freshProductData.productPrice,
                        ),
                      ),
                    );
                  },
                  productId: freshProductData.productId,
                  productImage: freshProductData.productImage,
                  productName: freshProductData.productName,
                  productPrice: freshProductData.productPrice,
                  productUnit:freshProductData,
                );
              },
            ).toList(),
          ),
        ),
      ],
    );
  }


  Widget _buildRootProduct() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Recommended for you'),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Search(
                        search: productProvider.getRootProductDataList,
                      ),
                    ),
                  );
                },
                child: Text(
                  'view all',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: productProvider.getRootProductDataList.map(
              (rootProductData) {
                return SingalProduct(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProductOverview(
                          productId: rootProductData.productId,
                          productImage: rootProductData.productImage,
                          productName: rootProductData.productName,
                          productPrice: rootProductData.productPrice,
                        ),
                      ),
                    );
                  },
                  productId: rootProductData.productId,
                  productImage: rootProductData.productImage,
                  productName: rootProductData.productName,
                  productPrice: rootProductData.productPrice,
                  productUnit: rootProductData,
                );
              },
            ).toList(),
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    ProductProvider initproductProvider = Provider.of(context, listen: false);
    initproductProvider.fetchCommingSoonProductData();
    initproductProvider.fetchRecentlyLaunchedProductData();
    initproductProvider.fetchRecommendedProductData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of(context);
    UserProvider userProvider = Provider.of(context);
    userProvider.getUserData();
    return Scaffold(
      drawer: DrawerSide(
        userProvider: userProvider,
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: textColor),
        title: Text(
          'Home',
          style: TextStyle(color: textColor, fontSize: 17),
        ),
        actions: [
          CircleAvatar(
            radius: 15,
            backgroundColor: Color(0xffd6d382),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        Search(search: productProvider.gerAllProductSearch),
                  ),
                );
              },
              icon: Icon(
                Icons.search,
                size: 17,
                color: textColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ReviewCart(),
                  ),
                );
              },
              child: CircleAvatar(
                backgroundColor: Color(0xffd6d382),
                radius: 15,
                child: Icon(
                  Icons.shop,
                  size: 17,
                  color: textColor,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: ListView(
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      'https://media.istockphoto.com/photos/school-picture-id1016131800?b=1&k=20&m=1016131800&s=170667a&w=0&h=imifkJTvS-4b8cvOhVNlCqqvZlwI4S-xCKZ6Oxbla4Q='),
                ),
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 130, bottom: 10),
                            child: Container(
                              height: 50,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Color(0xffd1ad17),
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(50),
                                  bottomLeft: Radius.circular(50),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Books',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    shadows: [
                                      BoxShadow(
                                          color: Colors.green,
                                          blurRadius: 10,
                                          offset: Offset(3, 3))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            '30% Off',
                            style: TextStyle(
                                fontSize: 40,
                                color: Colors.green[100],
                                fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              'On all Books',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                ],
              ),
            ),
            _buildHerbsProduct(context),
            _buildFreshProduct(context),
            _buildRootProduct(),
          ],
        ),
      ),
    );
  }
}
