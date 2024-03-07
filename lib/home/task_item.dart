import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_c10_monday/firebase/firebase_functions.dart';
import 'package:todo_c10_monday/task_model.dart';

class TaskItem extends StatelessWidget {
  TaskModel taskModel;

  TaskItem({required this.taskModel, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(18)),
      child: Slidable(
        startActionPane:
            ActionPane(motion: DrawerMotion(), extentRatio: .5, children: [
          SlidableAction(
            onPressed: (context) {
              FirebaseFunctions.deleteTask(taskModel.id ?? "");
            },
            backgroundColor: Colors.red,
            autoClose: true,
            icon: Icons.delete,
            label: "Delete",
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              bottomLeft: Radius.circular(25),
            ),
          ),
          SlidableAction(
            onPressed: (context) {},
            backgroundColor: Colors.blue,
            autoClose: true,
            icon: Icons.edit,
            label: "Edit",
          )
        ]),
        child: Container(
          padding: EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                height: 80,
                width: 8,
                decoration: BoxDecoration(
                    color: taskModel.isDone! ? Colors.green : Colors.blue,
                    borderRadius: BorderRadius.circular(25)),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      taskModel.title ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 25),
                    ),
                    Text(
                      taskModel.description ?? "",
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 12,
              ),
              InkWell(
                onTap: () {
                  taskModel.isDone = true;
                  FirebaseFunctions.updateTask(taskModel);
                },
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 12),
                    decoration: BoxDecoration(
                        color: taskModel.isDone! ? Colors.green : Colors.blue,
                        borderRadius: BorderRadius.circular(12)),
                    child: Icon(
                      Icons.done,
                      color: Colors.white,
                      size: 30,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// ""
// "Select * From TableName "
// "Insert Ito TableName value()"
