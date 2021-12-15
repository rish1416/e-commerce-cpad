import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_app/models/product_model.dart';

class ProductProvider with ChangeNotifier {
  ProductModel productModel;

  List<ProductModel> search = [];
  productModels(QueryDocumentSnapshot element) {
    
    productModel = ProductModel(
      productImage: element.get("productImage"),
      productName: element.get("productName"),
      productPrice: element.get("productPrice"),
      productId: element.get("productId"),
      productUnit: element.get("productUnit"),
    );
    search.add(productModel);
  }

  /////////////// herbsProduct ///////////////////////////////
  List<ProductModel> comingSoonProductList = [];

  fetchCommingSoonProductData() async {
    List<ProductModel> newList = [];

    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("ComingSoonProduct").get();
    value.docs.forEach(
      (element) {
        print(element.data());
        productModels(element);

        newList.add(productModel);
      },
    );
    comingSoonProductList = newList;
    notifyListeners();
  }

  List<ProductModel> get getComingSoonProductDataList {
    return comingSoonProductList;
  }

//////////////// recently launched product ///////////////////////////////////////

  List<ProductModel> recentlyLaunchedProductList = [];

  fetchRecentlyLaunchedProductData() async {
    List<ProductModel> newList = [];

    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("FreshProduct").get();

    value.docs.forEach(
      (element) {
        productModels(element);
        newList.add(productModel);
      },
    );
    recentlyLaunchedProductList = newList;
    notifyListeners();
  }

  List<ProductModel> get getFreshProductDataList {
    return recentlyLaunchedProductList;
  }

//////////////// Recommended product ///////////////////////////////////////

  List<ProductModel> recommendedProductList = [];

  fetchRecommendedProductData() async {
    List<ProductModel> newList = [];

    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("RootProduct").get();

    value.docs.forEach(
      (element) {
        productModels(element);
        newList.add(productModel);
      },
    );
    recommendedProductList = newList;
    notifyListeners();
  }

  List<ProductModel> get getRootProductDataList {
    return recommendedProductList;
  }

  /////////////////// Search Return ////////////
  List<ProductModel> get gerAllProductSearch {
    return search;
  }
}
