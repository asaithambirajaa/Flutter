import 'package:get/get.dart';
import 'package:getx/getX/model/product.dart';

class CartController extends GetxController {
  var cartItem = <Product>[].obs;
  int get cartCount => cartItem.length;
  double get totalPrice => cartItem.fold(0, (sum, item) => sum + item.price!);

  addToCart(Product product) {
    cartItem.add(product);
  }
}
