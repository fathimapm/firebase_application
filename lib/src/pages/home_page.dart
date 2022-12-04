
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_app/src/cubit/tasks/tasks_cubit.dart';
import 'package:firebase_app/src/models/task_model.dart';
import 'package:firebase_app/src/pages/create_task.dart';
import 'package:firebase_app/src/pages/edit_task.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TasksCubit()..getAllTasks(),
      child: Scaffold(
          appBar: AppBar(
            title: Text("Home page"),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => CreateTaskPage()))
                  .then((value) {
                context.read<TasksCubit>().getAllTasks();
              });
            },
            child: Icon(Icons.add),
          ),
          body: BlocBuilder<TasksCubit, TasksState>(
            builder: (context, state) {
              if (state is TasksLoading || state is TaskDeleting) {
                return CircularProgressIndicator();
              } else if (state is TasksLoaded) {
                return _buildTaskListView(context, state.tasks);
              } else if (state is TasksLoadError) {
                return Text("Failed to load data");
              } else {
                return Container();
              }
            },
          )),
    );
  }

  Widget _buildTaskListView(BuildContext context, List<TaskModel> tasks) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, pos) {
        TaskModel taskModel = tasks[pos];
        return ListTile(
          title: Text(taskModel.title),
          subtitle: Column(
            children: [
              Text(taskModel.description),
              Text("Start Date : ${taskModel.startDate.toString()}"),
              Text("End Date : ${taskModel.endDate.toString()}")
            ],
          ),
          trailing: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(taskModel.isCompleated ? "Done" : "Pending"),
              SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                            builder: (context) =>
                                EditTaskPage(taskModel: taskModel)))
                            .then((value) {
                          context.read<TasksCubit>().getAllTasks();
                        });
                      },
                      icon: Icon(Icons.edit)),
                  IconButton(
                      onPressed: () {
                        context.read<TasksCubit>().deleteTask(taskModel);
                      },
                      icon: Icon(Icons.delete))
                ],
              )
            ],
          ),
        );
      },
    );
  }
}