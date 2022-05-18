import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/getX/controller/cart_controller.dart';
import 'package:getx/getX/controller/shpping_controller.dart';

class ShoppingPage extends StatelessWidget {
  ShoppingPage({Key? key}) : super(key: key);

  final shoppingController = Get.put(ShoppingController());
  final cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'GetX',
          style: TextStyle(color: Colors.deepOrangeAccent),
        ),
        backgroundColor: Colors.black54,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: GetX<ShoppingController>(
                builder: (controller) {
                  return ListView.builder(
                    itemCount: controller.product.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.black54,
                        margin: const EdgeInsets.all(12),
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(controller
                                          .product[index].productName!),
                                      Text(
                                        controller
                                            .product[index].productDescription!,
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 11),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '\$${controller.product[index].price!}',
                                    style: TextStyle(
                                        color: Colors.deepOrange,
                                        fontSize: 20.0),
                                  )
                                ],
                              ),
                              RaisedButton(
                                onPressed: () {
                                  cartController
                                      .addToCart(controller.product[index]);
                                },
                                color: Colors.white10,
                                child: Text('Add to Cart'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            GetX<CartController>(
              builder: (cController) {
                return Text(
                  'Total amount \$ ${cController.totalPrice}',
                  style: TextStyle(fontSize: 32, color: Colors.orange),
                );
              },
            ),
            SizedBox(height: 100)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: GetX<CartController>(
          builder: (controller) {
            return Text('${controller.cartCount}');
          }
        ),
        backgroundColor: Colors.red,
        icon: Icon(Icons.add_shopping_cart_sharp, color: Colors.black54,),
      ),
    );
  }
}
