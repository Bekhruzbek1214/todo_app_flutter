import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/data/local/shared_preference.dart';
import 'package:todo_app/data/local/sqflite/db_helper.dart';
import 'package:todo_app/feature/bloc/home/home_bloc.dart';
import 'package:todo_app/feature/bloc/home/home_event.dart';
import 'package:todo_app/feature/bloc/home/home_state.dart';
import 'add_task/add_task_screen.dart';
import 'home_widgets/custom_clock.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late HomeBloc _homeBloc;
  String dropdownValue = 'study';
  DateTime _dateTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    _homeBloc = HomeBloc(SharedPreferenceHelper(), MyDatabaseHelper());
    _homeBloc.add(LoadTodoData());

    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _dateTime = DateTime.now();
      });
    });
  }




  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;


    return BlocProvider(
      create: (_) => _homeBloc,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Container(
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),

                  ),
                  child: SizedBox(
                    //margin: EdgeInsets.all(20),
                    height: 40,
                    width: width-100,
                    child: DropdownButton<String>(
                      value: dropdownValue,
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: <String>['study', 'work', 'personal', 'other']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, style: const TextStyle(fontSize: 20, color: Colors.black), textAlign: TextAlign.center,),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                   final result = await Navigator.push(context,
                       MaterialPageRoute(
                        builder: (context) => const AddTaskScreen())
                    );
                   if(result){
                     _homeBloc.add(LoadTodoData());
                   }
                  },
                  child: const Icon(Icons.add, color: Colors.blue, size: 30,),
                )

                ]
              ),
              const SizedBox(height: 16),
              const Text(
                'Current Task',
                style: TextStyle(fontSize: 28, color: Colors.black),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.pinkAccent),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SizedBox(
                  height: height/3.5,
                  width: width-10,
                  child: Column(
                    children: [
                      const Text('Have dinner', style: TextStyle(fontSize: 24)),
                      Text(
                          '${_dateTime.hour > 9 ? _dateTime.hour : '0${_dateTime.hour}'} : '
                          '${_dateTime.minute > 9 ? _dateTime.minute : '0${_dateTime.minute}'}',
                          style: const TextStyle(fontSize: 20)),
                      const SizedBox(height: 16),
                      CustomPaint(
                        size: const Size(150, 150), // Customize this size
                        painter: CustomClockPainter(_dateTime),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Task', style: TextStyle(fontSize: 24)),
              const SizedBox(height: 16),
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if(state is HomeLoading){
                    return const Center(child: CircularProgressIndicator());
                  }
                  else if (state is HomeLoaded){
                    return state.todoList.isEmpty ?
                        const Center(child: Text("Now Empty")):
                        Expanded(
                         child: ListView(
                            children: [
                              TaskItem(title: 'have dinner', time: '20:00', color: Colors.pinkAccent),
                              TaskItem(title: 'wake up', time: '7:00', color: Colors.greenAccent),
                              TaskItem(title: 'exercise', time: '9:00', color: Colors.redAccent),
                              TaskItem(title: 'study', time: '9:00', color: Colors.orangeAccent),
                              TaskItem(title: 'shopping', time: '12:30', color: Colors.yellowAccent),
                            ],
                         ),
                    );
                  }else{
                    return const Center(child: CircularProgressIndicator());
                  }
                },

              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TaskItem extends StatelessWidget {
  final String title;
  final String time;
  final Color color;

  TaskItem({required this.title, required this.time, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color,
            child: color == Colors.greenAccent
                ? const Icon(Icons.check, color: Colors.white)
                : null,
          ),
          const SizedBox(width: 8),
          Text(title, style: const TextStyle(fontSize: 18)),
          const Spacer(),
          Text(time, style: const TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.pinkAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), size.width / 2, paint);

    final handPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 4;

    canvas.drawLine(Offset(size.width / 2, size.height / 2),
        Offset(size.width / 2, size.height / 4), handPaint);
    canvas.drawLine(Offset(size.width / 2, size.height / 2),
        Offset(size.width * 3 / 4, size.height / 2), handPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
