import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:getx/login/models/models.dart';

class ChatController extends GetxController {
  User sender;
  UserModel receiver;

  ChatController({required this.sender, required this.receiver});

  static ChatController to = Get.find();
  TextEditingController messageTxtController = TextEditingController();
  FocusNode textFieldFocus = FocusNode();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Rxn<List<Message>> message = Rxn<List<Message>>();

  List<Message> get messageModelList => message.value!;
  final _isLoading = true.obs;

  bool get isLoading => _isLoading.value;

  Future<void> addMessageToDb(BuildContext context) {
    Message _message = Message(
      receiverId: receiver.uid,
      senderId: sender.uid,
      message: messageTxtController.text,
      timestamp: Timestamp.now(),
      date: DateTime.now().toUtc(),
      type: 'text',
    );
    messageTxtController.clear();
    var map = _message.toMap();
    _db
        .collection('messages')
        .doc(sender.uid)
        .collection(receiver.uid)
        .add(map);
    return _db
        .collection('messages')
        .doc(receiver.uid)
        .collection(sender.uid)
        .add(map);
  }

  Stream<List<Message>> streamMessage() {
    return FirebaseFirestore.instance
        .collection('messages')
        .doc(sender.uid)
        .collection(receiver.uid)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((ds) {
      var mapData = ds.docs;
      List<Message> _message = [];
      mapData.forEach((element) {
        _message.add(Message.fromMap(element.data()));
      });
      _isLoading.value = false;
      return _message;
    });
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    message.bindStream(streamMessage());
  }

  @override
  void onClose() {
    messageTxtController.dispose();
    super.onClose();
  }
}
