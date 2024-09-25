import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/data/local/sqflite/db_helper.dart';
import 'package:todo_app/feature/bloc/add/add_bloc.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _dateControllerDate = TextEditingController();
  final TextEditingController _dateControllerTime = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _date = '';
  String _category = 'Work';
  String _importance = 'Very Important';
  Color _color = Colors.green;
  String _time = '09:00';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => AddBloc(MyDatabaseHelper()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Task'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Name',
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue)),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _name = value;
                            });
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _dateControllerDate,
                          decoration: const InputDecoration(
                            labelText: 'Date',
                            filled: true,
                            prefixIcon: Icon(Icons.calendar_today),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue)),
                          ),
                          readOnly: true,
                          onTap: () {
                            _selectDate();
                          },
                        ),
                        const SizedBox(height: 10),
                        DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: 'Category',
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue)),
                          ),
                          value: _category,
                          items: ['Work', 'Personal', 'Other']
                              .map((category) => DropdownMenuItem<String>(
                            value: category,
                            child: Text(category),
                          ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _category = value!;
                            });
                          },
                        ),
                        const SizedBox(height: 10),
                        DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: 'Level importance',
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue)),
                          ),
                          value: _importance,
                          items: ['Very Important', 'Important', 'Normal']
                              .map((importance) => DropdownMenuItem<String>(
                            value: importance,
                            child: Text(importance),
                          ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _importance = value!;
                            });
                          },
                        ),
                        const SizedBox(height: 10.0),
                        TextFormField(
                          controller: _dateControllerTime,
                          decoration: const InputDecoration(
                            labelText: 'Set alarm',
                            filled: true,
                            prefixIcon: Icon(Icons.access_time),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue)),
                          ),
                          readOnly: true,
                          onTap: () {
                            _selectTime();
                          },
                        ),
                        const SizedBox(height: 16),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Wrap(
                              spacing: 10.0,
                              children: [
                                ColorCircle(
                                  color: Colors.green,
                                  isSelected: _color == Colors.green,
                                  onTap: () {
                                    setState(() {
                                      _color = Colors.green;
                                    });
                                  },
                                ),
                                ColorCircle(
                                  color: Colors.orange,
                                  isSelected: _color == Colors.orange,
                                  onTap: () {
                                    setState(() {
                                      _color = Colors.orange;
                                    });
                                  },
                                ),
                                ColorCircle(
                                  color: Colors.yellow,
                                  isSelected: _color == Colors.yellow,
                                  onTap: () {
                                    setState(() {
                                      _color = Colors.yellow;
                                    });
                                  },
                                ),
                                ColorCircle(
                                  color: Colors.blue,
                                  isSelected: _color == Colors.blue,
                                  onTap: () {
                                    setState(() {
                                      _color = Colors.blue;
                                    });
                                  },
                                ),
                                ColorCircle(
                                  color: Colors.pink,
                                  isSelected: _color == Colors.pink,
                                  onTap: () {
                                    setState(() {
                                      _color = Colors.pink;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: size.width - 32,
                    height: 50,
                    margin: const EdgeInsets.only(bottom: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Add task logic
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: const Text(
                        'Add',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _date = picked.toString();
        _dateControllerDate.text = picked.toString().substring(0, 10);
      });
    }
  }

  Future<void> _selectTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        _time = pickedTime.toString();
        _dateControllerTime.text =
        "${pickedTime.hour} : ${pickedTime.minute < 10 ? '0${pickedTime.minute}' : pickedTime.minute}";
      });
    }
  }
}

class ColorCircle extends StatelessWidget {
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const ColorCircle({
    super.key,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: isSelected ? Border.all(color: Colors.black, width: 2) : null,
        ),
      ),
    );
  }
}
