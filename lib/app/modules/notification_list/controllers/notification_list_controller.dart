import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class NotificationListController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Object?>> streamNotification(String userId) {
    CollectionReference notification = firestore.collection("notification");

    return notification.snapshots();
  }

  void setIsOpened(String notificationId) {
    DocumentReference docRef =
        firestore.collection('notification').doc(notificationId);

    docRef.update({'isOpened': true});
  }
}
