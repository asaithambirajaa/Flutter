import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getx/login/constants/app_themes.dart';
import 'package:getx/login/controllers/chat_controller.dart';
import 'package:get/get.dart';
import 'package:getx/login/models/messages.dart';

class ChatUI extends StatelessWidget {
  final ChatController chatController = Get.put(ChatController(
    sender: Get.arguments[0],
    receiver: Get.arguments[1],
  ));
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _formKey,
      appBar: AppBar(
        title: Text('chat.title'.tr),
        actions: [
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Flexible(
            child: messageList(),
          ),
          Row(
            children: [
              Expanded(
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    TextField(
                      controller: chatController.messageTxtController,
                      focusNode: chatController.textFieldFocus,
                      // onTap: () => hideEmojiContainer(),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      onChanged: (val) {
                        // (val.length > 0 && val.trim() != "")
                        //     ? setWritingTo(true)
                        //     : setWritingTo(false);
                      },
                      decoration: InputDecoration(
                        hintText: "Type a message",
                        hintStyle: TextStyle(
                          color: AppThemes.nevada,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(50.0),
                            ),
                            borderSide: BorderSide.none),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        filled: true,
                        fillColor: AppThemes.blackPearl,
                      ),
                    ),
                    IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        // if (!showEmojiPicker) {
                        //   // keyboard is visible
                        //   hideKeyboard();
                        //   showEmojiContainer();
                        // } else {
                        //   //keyboard is hidden
                        //   showKeyboard();
                        //   hideEmojiContainer();
                        // }
                      },
                      icon: Icon(Icons.face),
                    ),
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      gradient: AppThemes.fabGradient, shape: BoxShape.circle),
                  child: IconButton(
                    icon: Icon(
                      Icons.send,
                      size: 15,
                    ),
                    onPressed: () => chatController.addMessageToDb(context),
                  ))
            ],
          ),
        ],
      ),
    );
  }

  Widget messageList() {
    return GetX<ChatController>(
      builder: (controller) {
        return controller.isLoading ? Center(child: CupertinoActivityIndicator(),) : ListView.builder(
          padding: EdgeInsets.all(10),
          //controller: _listScrollController,
          reverse: true,
          itemCount: controller.messageModelList.length,
          itemBuilder: (context, index) {
            // mention the arrow syntax if you get the time
            return chatMessageItem(context, controller.messageModelList[index]);
          },
        );
      },
    );
  }

  Widget chatMessageItem(BuildContext context, Message messages) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Container(
        alignment: messages.senderId == chatController.sender.uid
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: messages.senderId == chatController.sender.uid
            ? senderLayout(context, messages)
            : receiverLayout(context, messages),
      ),
    );
  }

  Widget senderLayout(BuildContext context, Message message) {
    Radius messageRadius = Radius.circular(10);

    return Container(
      margin: EdgeInsets.only(top: 12),
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.65),
      decoration: BoxDecoration(
        color: AppThemes.senderColor,
        borderRadius: BorderRadius.only(
          topLeft: messageRadius,
          topRight: messageRadius,
          bottomLeft: messageRadius,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: getMessage(message),
      ),
    );
  }

  getMessage(Message message) {
    return message.type != 'image'
        ? Column(
          children: [
            Text(
                message.message!,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            Text(
              '${message.date!.toLocal()}',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ],
        )
        : message.photoUrl != null
            ? CachedNetworkImage(
                imageUrl: message.photoUrl!,
                height: 250,
                width: 250,
              )
            : Text("Url was null");
  }

  Widget receiverLayout(BuildContext context, Message message) {
    Radius messageRadius = Radius.circular(10);

    return Container(
      margin: EdgeInsets.only(top: 12),
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.65),
      decoration: BoxDecoration(
        color: AppThemes.receiverColor,
        borderRadius: BorderRadius.only(
          bottomRight: messageRadius,
          topRight: messageRadius,
          bottomLeft: messageRadius,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: getMessage(message),
      ),
    );
  }
}
