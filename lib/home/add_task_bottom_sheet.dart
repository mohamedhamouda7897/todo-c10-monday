import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_c10_monday/firebase/firebase_functions.dart';
import 'package:todo_c10_monday/task_model.dart';

class AddTaskBottomSheet extends StatefulWidget {
  AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  DateTime chosenDate = DateTime.now();

  var titleController = TextEditingController();

  var descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Add New task",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 26,
          ),
          TextFormField(
            controller: titleController,
            decoration: InputDecoration(
                label: const Text("Title"),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(12)),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(12))),
          ),
          const SizedBox(
            height: 26,
          ),
          TextFormField(
            controller: descriptionController,
            decoration: InputDecoration(
                label: const Text("Description"),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(12)),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(12))),
          ),
          const SizedBox(
            height: 26,
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              "Select Time",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          InkWell(
            onTap: () {
              selectDate(context);
            },
            child: Text(
              "${chosenDate.toString().substring(0, 10)}",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w100),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  print(chosenDate);
                  TaskModel model = TaskModel(
                      title: titleController.text,
                      userId: FirebaseAuth.instance.currentUser!.uid,
                      date:
                          DateUtils.dateOnly(chosenDate).millisecondsSinceEpoch,
                      description: descriptionController.text);
                  FirebaseFunctions.addTask(model);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: const Text(
                  "Add Task",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      color: Colors.white),
                )),
          )
        ],
      ),
    );
  }

  selectDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: chosenDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        Duration(days: 360),
      ),
      selectableDayPredicate: (day) =>
          day != DateTime.now().add(Duration(days: 2)),
    );
    if (selectedDate != null) {
      chosenDate = selectedDate!;
      setState(() {});
    }
  }
}
