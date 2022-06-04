import 'package:get/get.dart';

import '../Class/task.dart';
import '../DB/Db_helper.dart';

class TaskController extends GetxController{
  @override
  void onRead(){
    super.onReady();
  }
  var taskList = <Task>[].obs;

  Future<int> addTask({Task? task}) async{
    return await DBHelper.insert(task);
  }
  void getTasks() async{
    List<Map<String,dynamic>> task = await DBHelper.query();
    taskList.assignAll(task.map((data) => new Task.fromJson(data)).toList());
  }

}