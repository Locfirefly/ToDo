import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:taskmanager/Services/notification_services.dart';
import 'package:taskmanager/Services/theme_services.dart';
import 'package:get/get.dart';
import 'package:taskmanager/UI/theme.dart';
import 'package:taskmanager/UI/widgets/button.dart';

import '../controller/task_controller.dart';
import 'add_task_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectedDate = DateTime.now();
  final _taskController = Get.put(TaskController());
  var notifyHelper;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notifyHelper= NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(),
      body: Column(
        children: [
          _body(),
          _addDateBar(),
        ],
      ),
    );
  }

  _addDateBar(){
   return  Container(
     margin: const EdgeInsets.only(top: 20,left: 20),
     child: DatePicker(
       DateTime.now(),
       height: 100,
       width: 80,

       initialSelectedDate: DateTime.now(),
       selectionColor: bluishClr,
       selectedTextColor: Colors.white,
       dateTextStyle: GoogleFonts.lato(
         textStyle: TextStyle(
           fontSize: 20,
           fontWeight: FontWeight.w600,
           color: Colors.grey,
         ),
       ),
       dayTextStyle: GoogleFonts.lato(
         textStyle: TextStyle(
           fontSize: 13,
           fontWeight: FontWeight.w600,
           color: Colors.grey,
         ),
       ),
       monthTextStyle: GoogleFonts.lato(
         textStyle: TextStyle(
           fontSize: 13,
           fontWeight: FontWeight.w600,
           color: Colors.grey,
         ),
       ),
       onDateChange: (date){
         _selectedDate = date;
       },
     ),
   );
  }
  _body(){
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20,top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(DateFormat.yMMMd().format(DateTime.now()),
                  style: subHeadingStyle,
                ),
                Text("Today",
                  style: headingStyle,
                ),
              ],
            ),
          ),
          MyButton(label: "+ Add Task", onTap: ()=> Get.to(AddTaskPage()))
        ],
      ),
    );
  }
  _appBar(){
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: (){
          ThemeService().switchTheme();
          /*notifyHelper.displayNotification(
            title: "Theme ChangeD",
              body: Get.isDarkMode?"Activated Dark Theme":"Activated Light Theme"
          );*/
        },
        child: Icon(Get.isDarkMode?Icons.wb_sunny_outlined: Icons.nightlight_round ,
        size: 25,
          color: Get.isDarkMode? Colors.white:Colors.black,
        ),
      ),
      actions: const [
        CircleAvatar(
          backgroundImage: AssetImage(
            "image/avatar2.png"
          ),
        ),
        SizedBox(width: 25,)
      ],
    );
  }
}
