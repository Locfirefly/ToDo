import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:taskmanager/UI/widgets/button.dart';
import 'package:taskmanager/UI/widgets/input_field.dart';
import '../Class/task.dart';
import '../controller/task_controller.dart';
import 'theme.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);


  @override
  State<AddTaskPage> createState() => _AddTaskPageState();

}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController _titlecontroller = TextEditingController();
  final TextEditingController _notecontroller = TextEditingController();
  final TaskController _taskController = Get.put(TaskController());
  Color color = Colors.red;
  DateTime _selectedDate = DateTime.now();
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  String _endTime = ("--:--");
  int _selectedRemind = 5;
  List<int> remindList=[5,10,15,20];
  String _selectedRepeat = "None";
  List<String> repeatList=["None","Daily","Weekly" ,"Monthly"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add Task",
                style: headingStyle,
              ),
              MyInputField(title: "Title", hint: "Enter your title", controller: _titlecontroller,),
              MyInputField(title: "Note", hint: "Enter your note",controller: _notecontroller,),
              MyInputField(title: "Date", hint: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                  icon: Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    _opencalendar();
                  },
                ),),
              Row(
                children: [
                  Expanded(
                    child: MyInputField(
                      title: "Start Date",
                      hint: _startTime,
                      widget: IconButton(
                        onPressed: (){
                          _opentimepicker(isStarTime: true);
                        },
                        icon: Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12,),
                  Expanded(
                    child: MyInputField(
                      title: "End Date",
                      hint: _endTime,
                      widget: IconButton(
                        onPressed: (){
                          _opentimepicker(isStarTime: false);
                        },
                        icon: Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              MyInputField(title: "Remind", hint: "$_selectedRemind minutes early",
                   widget: DropdownButton(
                     icon: Icon(Icons.keyboard_arrow_down,
                       color: Colors.grey,
                     ),
                     iconSize: 32,
                     elevation: 4,
                     style: subtitleStyle,
                     underline: Container(height: 0,),
                     onChanged: (String? newValue){
                       setState(() {
                         _selectedRemind = int.parse(newValue!);
                       });
                     },
                     items: remindList.map<DropdownMenuItem<String>>((int value){
                       return DropdownMenuItem<String>(
                         value: value.toString(),
                         child: Text(value.toString()),
                       );
                     }
                     ).toList(),
                   ),
              ),
              MyInputField(title: "Repeat", hint: "$_selectedRepeat",
                widget: DropdownButton(
                  icon: Icon(Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  style: subtitleStyle,
                  underline: Container(height: 0,),
                  onChanged: (String? newValue){
                    setState(() {
                      _selectedRepeat = newValue!;
                    });
                  },
                  items: repeatList.map<DropdownMenuItem<String>>((String value){
                    return DropdownMenuItem<String>(
                      value: value.toString(),
                      child: Text(value, style: TextStyle(color: Colors.grey),),
                    );
                  }
                  ).toList(),
                ),
              ),
              SizedBox(
                height: 17,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Color",
                      style: titleStyle,
                      ),
                      SizedBox(height: 8.0),
                      GestureDetector(
                        onTap: (){
                          _pickColor(context);
                        },
                        child: CircleAvatar(
                          radius: 14,
                          backgroundColor: color,
                        ),
                      ),
                    ],
                  ),
                  MyButton(label: "Create Task",
                    onTap: (){
                    _validate();
                  }
                  ,)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _pickColor(BuildContext context){
    showDialog(
      context: context,
      builder: (context)=> AlertDialog(
        title: Text("Pick your color"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildColorPicker(),
            TextButton(
              child: Text("Select",
                style: subHeadingStyle,
              ),
              onPressed: () { Navigator.of(context).pop(); },
            ),
          ],
        ),
      ),
    );

  }
  _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Icon(
          Icons.arrow_back_ios,
          size: 25,
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
    );
  }
  _opencalendar() async {
    DateTime? _pickerdate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1888),
      lastDate: DateTime(2122),
    );
    if (_pickerdate != null) {
      setState(() {
        _selectedDate = _pickerdate;
        print(_selectedDate);
      });
    } else {
      print("something wrong");
    }
  }
  _opentimepicker({required bool isStarTime}) async{
    var pickedTime = await _showTimePicker();
    String _formatedTime = pickedTime.format(context);
    if(pickedTime==null){
      print("Error");
    } else if(isStarTime == true){
      setState(() {
        _startTime=_formatedTime;
      });
    }else if(isStarTime == false){
      setState(() {
        _endTime=_formatedTime;
      });
    }
  }
  _showTimePicker(){
    return showTimePicker(
        context: context,
        initialTime: TimeOfDay(
            hour: int.parse(_startTime.split(":")[0]),
            minute: int.parse(_startTime.split(":")[1].split(" ")[0]),
    )
    );
  }
  _validate(){
    if(_titlecontroller.text.isNotEmpty && _notecontroller.text.isNotEmpty){
      _addDB();
      Get.back();
    }else if(_titlecontroller.text.isEmpty || _notecontroller.text.isEmpty){
      Get.snackbar("Caution", "All fields are required",
      snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white,
        icon: Icon(Icons.warning_amber_outlined),
      );
    }
  }
  buildColorPicker() => BlockPicker(
    pickerColor: color,
      availableColors: const [
        Colors.deepOrange,
        Colors.orange,
        Colors.pinkAccent,
        Colors.deepPurple,
        Colors.amber,
        Colors.redAccent,
        Colors.teal,
        Colors.pink,
        Colors.indigoAccent,
        Colors.blue,
        Colors.cyan,
        Colors.deepPurpleAccent,
        Colors.purpleAccent,
        Colors.lightGreen,
        Colors.orangeAccent,
        Colors.red,
        Colors.yellow,
        Colors.blueGrey,
        Colors.cyanAccent,
        Colors.tealAccent,
      ],
      onColorChanged: (color) { setState(() {
        this.color = color;
      });
      },
    );
  _addDB()async{
    int value = await _taskController.addTask(
    task:Task(
      note: _notecontroller.text,
      title: _titlecontroller.text,
      date: DateFormat.yMd().format(_selectedDate),
      startTime: _startTime,
      endTime: _endTime,
      color:  color.toString(),
      remind: _selectedRemind,
      repeat: _selectedRepeat,
      isCompleted: 0,
    )
    );
    print("id "+"$value");
  }


}
