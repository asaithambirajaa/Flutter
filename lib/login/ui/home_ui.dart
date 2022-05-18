import 'package:flutter/material.dart';
import 'package:getx/login/controllers/controller.dart';
import 'package:getx/login/models/models.dart';
import 'package:getx/login/ui/components/components.dart';
import 'package:getx/login/ui/ui.dart';
import 'package:get/get.dart';

class HomeUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String _imageLogo = 'assets/images/default.png';
    return Scaffold(
      appBar: AppBar(
        title: Text('home.title'.tr),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Get.to(SettingsUI());
            },
          ),
        ],
      ),
      body: GetBuilder<AuthController>(builder: (_controller) {
        if (_controller.usersModelList == null) {
          return Text('Loading');
        } else if (_controller.usersModelList.isEmpty) {
          return Text('Empty List');
        } else {
          return ListView.builder(
            itemCount: _controller.usersModelList.length,
            itemBuilder: (context, index) {
              return _controller.usersModelList[index].uid != _controller.firebaseUser.value!.uid ? ListTile(
                onTap: () {
                  Get.toNamed('/chat', arguments: [_controller.firebaseUser.value!, _controller.usersModelList[index]]);
                },
                leading: CircleAvatar(
                  foregroundColor: Colors.blue,
                  backgroundColor: Colors.transparent,
                  //radius: 60.0,
                  child: ClipOval(
                    child: Image.asset(
                      _imageLogo,
                      fit: BoxFit.cover,
                      width: 50.0,
                      height: 50.0,
                    ),
                  ),
                ),
                title: Text(
                  _controller.usersModelList[index].name,
                  style: TextStyle(fontSize: 15.0),
                ),
                subtitle: Text(
                  _controller.usersModelList[index].email,
                  style: TextStyle(fontSize: 15.0),
                ),
              ) : SizedBox();
            },
          );
        }
      }),
    );
    /*return GetX<AuthController>(
      init: AuthController(),
      builder: (controller) => controller.firestoreUser.value!.uid == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              appBar: AppBar(
                title: Text('home.title'.tr),
                actions: [
                  IconButton(
                    icon: Icon(Icons.settings),
                    onPressed: () {
                      Get.to(SettingsUI());
                    },
                  ),
                ],
              ),
              body: Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 120),
                    Avatar(controller.firestoreUser.value!),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FormVerticalSpace(),
                        Text(
                            'home.uidLabel'.tr +
                                ': ' +
                                controller.firestoreUser.value!.uid,
                            style: TextStyle(fontSize: 16)),
                        FormVerticalSpace(),
                        Text(
                            'home.nameLabel'.tr +
                                ': ' +
                                controller.firestoreUser.value!.name,
                            style: TextStyle(fontSize: 16)),
                        FormVerticalSpace(),
                        Text(
                            'home.emailLabel'.tr +
                                ': ' +
                                controller.firestoreUser.value!.email,
                            style: TextStyle(fontSize: 16)),
                        FormVerticalSpace(),
                        Text(
                            'home.adminUserLabel'.tr +
                                ': ' +
                                controller.admin.value.toString(),
                            style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );*/
  }
}
