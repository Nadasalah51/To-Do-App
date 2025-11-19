import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taskey_app/auth/data/model/user_model.dart';
import 'package:taskey_app/core/network/result_firebase.dart';
import 'package:taskey_app/home/data/model/task_model.dart';

abstract class FirebaseTask {
 static CollectionReference<TaskModel> get _getCollection {
    final tokenUser = FirebaseAuth.instance.currentUser?.uid;
    return FirebaseFirestore.instance
        .collection(UserModel.collection)
        .withConverter(
          fromFirestore: (doc, _) => UserModel.fromJson(doc.data()!),
          toFirestore: (user, _) => user.toJson(),
        )
        .doc(tokenUser)
        .collection(TaskModel.collectionName)
        .withConverter<TaskModel>(
          fromFirestore: (doc, _) => TaskModel.fromJson(doc.data()!),
          toFirestore: (task, _) => task.toJoson(),
        );
  }

 static Future<ResultFB<void>> addTask(TaskModel task) async {
    // await _getCollection.doc().set(task);
    try {
      final doc = _getCollection.doc();
      task.id = doc.id;
      await doc.set(task);
      return SuccessFB();
    } catch (e) {
      return ErrorFB(messageError: e.toString());
    }
  }
}
