import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_c10_monday/auth/auth.dart';
import 'package:todo_c10_monday/firebase/firebase_functions.dart';
import 'package:todo_c10_monday/home/add_task_bottom_sheet.dart';
import 'package:todo_c10_monday/home/tabs/settings_tab.dart';
import 'package:todo_c10_monday/home/tabs/tasks_tab.dart';
import 'package:todo_c10_monday/providers/my_provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "Home";

  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Scaffold(
      extendBody: true,
      backgroundColor: Color(0xFFDFECDB),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "ToDo ${provider.userModel?.userName}",
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseFunctions.logOut();
                Navigator.pushNamedAndRemoveUntil(
                    context, AuthScreen.routeName, (route) => false);
              },
              icon: Icon(Icons.logout))
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: AddTaskBottomSheet());
            },
          );
        },
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(color: Colors.white, width: 3)),
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 35,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        padding: EdgeInsets.zero,
        notchMargin: 8,
        height: 60,
        color: Colors.white,
        child: BottomNavigationBar(
            currentIndex: index,
            onTap: (value) {
              index = value;
              setState(() {});
            },
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey.shade400,
            showUnselectedLabels: false,
            showSelectedLabels: false,
            elevation: 0,
            backgroundColor: Colors.transparent,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.task,
                  ),
                  label: ""),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                  ),
                  label: ""),
            ]),
      ),
      body: tabs[index],
    );
  }

  List<Widget> tabs = [TasksTab(), SettingsTab()];
}
