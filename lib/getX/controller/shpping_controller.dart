import 'package:get/get.dart';
import 'package:getx/getX/model/product.dart';

class ShoppingController extends GetxController {
  var product = <Product>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchProducts();
  }

  void fetchProducts() async {
    await Future.delayed(Duration(seconds: 1));
    var productsResult = [
      Product(
          id: 1,
          price: 50.0,
          productDescription:
              'In literary theory, a text is any object that can be "read"',
          productImage: '',
          productName: 'YIU'),
      Product(
          id: 3,
          price: 40.0,
          productDescription:
              'In literary theory, a text is any object that can be "read"',
          productImage: '',
          productName: 'RTY'),
      Product(
          id: 2,
          price: 30.0,
          productDescription:
              'In literary theory, a text is any object that can be "read"',
          productImage: '',
          productName: 'ABC'),
    ];
    product.value = productsResult;
  }
}
