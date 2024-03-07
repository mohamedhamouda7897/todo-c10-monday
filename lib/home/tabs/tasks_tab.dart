import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_c10_monday/firebase/firebase_functions.dart';
import 'package:todo_c10_monday/home/task_item.dart';
import 'package:todo_c10_monday/task_model.dart';

class TasksTab extends StatefulWidget {
  TasksTab({super.key});

  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DatePicker(
          DateTime.now(),
          initialSelectedDate: selectedDate,
          selectionColor: Colors.blue,
          selectedTextColor: Colors.white,
          height: 90,
          locale: "en",
          dateTextStyle: const TextStyle(fontSize: 12),
          monthTextStyle: const TextStyle(fontSize: 16),
          dayTextStyle: const TextStyle(fontSize: 16),
          onDateChange: (date) {
            selectedDate = date;
            setState(() {});
          },
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot<TaskModel>>(
            stream: FirebaseFunctions.getTasks(selectedDate),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Column(
                  children: [
                    const Text("Something went wrong"),
                    ElevatedButton(
                        onPressed: () {}, child: const Text("Try Again"))
                  ],
                );
              }
              var tasks =
                  snapshot.data?.docs.map((e) => e.data()).toList() ?? [];
              if (tasks.isEmpty) {
                return Center(child: Text("No Tasks"));
              }
              return ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  height: 12,
                ),
                itemBuilder: (context, index) {
                  return TaskItem(
                    taskModel: tasks[index],
                  );
                },
                itemCount: tasks.length,
              );
            },
          ),
        )
      ],
    );
  }
}
