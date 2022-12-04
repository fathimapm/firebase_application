import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:firebase_app/src/cubit/tasks/tasks_repository.dart';
import 'package:firebase_app/src/models/task_model.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {

  TasksRepository _repository = TasksRepository();
  TasksCubit() : super(TasksInitial());

  createTasks(TaskModel taskModel) async{
    emit(TaskCreating());
    try{
      await _repository.createTasks(taskModel);
      emit(TaskCreated());
      await Future.delayed(Duration(seconds: 1));
      getAllTasks();
    }catch(ex){
      emit(TaskCreateError());
    }
  }

  updateTask(TaskModel taskModel) async{
    emit(TaskUpdating());
    try{
      await _repository.updateTasks(taskModel);
      emit(TaskUpdated());
      await Future.delayed(Duration(seconds: 1));
      getAllTasks();
    }catch(ex){
      emit(TaskUpdateError());
    }

  }

  deleteTask(TaskModel taskModel) async{
    emit(TaskDeleting());
    try{
      await _repository.deleteTasks(taskModel);
      emit(TaskDeleted());
      await Future.delayed(Duration(seconds: 1));
      getAllTasks();
    }catch(ex){
      emit(TaskDeleteError());
    }
  }

  getAllTasks() async{
    emit(TasksLoading());
    try{
      QuerySnapshot snapshot = await _repository.getTasks();
      List<TaskModel> taskList = snapshot.docs.map((e){
        Map<String,dynamic>  dx = e.data() as Map<String,dynamic>;
        String id = e.id;
        TaskModel taskModel = TaskModel.fromJson(dx);
        taskModel.id = id;
        return taskModel;
      }).toList();
      emit(TasksLoaded(taskList));
    }catch(ex){
      emit(TasksLoadError());
    }
  }
}