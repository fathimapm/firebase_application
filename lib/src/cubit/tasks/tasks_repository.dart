import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/src/helper/storage_helper.dart';
import 'package:firebase_app/src/helper/storage_keys.dart';
import 'package:firebase_app/src/models/task_model.dart';
class TasksRepository{
  createTasks(TaskModel taskModel)async{
    String? uid = await StorageHelper.readData(StorageKeys.uid.name);
    CollectionReference  reference= FirebaseFirestore.instance.collection("users").doc("$uid").collection("tasks");
    reference.add(taskModel.toJson());
  }

  Future<QuerySnapshot> getTasks()async{
    String? uid = await StorageHelper.readData(StorageKeys.uid.name);
    CollectionReference  reference = FirebaseFirestore.instance.collection("users").doc("$uid").collection("tasks");
    QuerySnapshot snapshot = await reference.get();
    return snapshot;
  }
  updateTasks(TaskModel updatedTask)async {
    String? uid = await StorageHelper.readData(StorageKeys.uid.name);
    CollectionReference reference = FirebaseFirestore.instance.collection(
        "users").doc("$uid").collection("tasks");
    reference.doc("${updatedTask.id}").update(updatedTask.toJson());
  }
  deleteTasks(TaskModel  updatedTask)async{
    String? uid = await StorageHelper.readData(StorageKeys.uid.name);
    CollectionReference reference = FirebaseFirestore.instance.collection(
        "users").doc("$uid").collection("tasks");
    reference.doc("${ updatedTask.id}").delete();
  }
}
