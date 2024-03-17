import 'dart:async';
import 'package:flutter/material.dart';

class DailySchedulePage extends StatefulWidget {
  @override
  _DailySchedulePageState createState() => _DailySchedulePageState();
}

class _DailySchedulePageState extends State<DailySchedulePage> {
  late TextEditingController _taskNameController;
  late TextEditingController _timeController;
  late TextEditingController _durationController;
  List<Task> tasks = [];

  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _taskNameController = TextEditingController();
    _timeController = TextEditingController();
    _durationController = TextEditingController();
    _loadInitialTasks();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    _taskNameController.dispose();
    _timeController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  void _loadInitialTasks() {
    tasks.addAll([
      Task(name: 'Task 1', time: '10:00 AM', duration: '1 hour'),
      Task(name: 'Task 2', time: '2:00 PM', duration: '30 minutes'),
      Task(name: 'Task 3', time: '12:00 PM', duration: '45 minutes'),
    ]);
    tasks.sort((a, b) => _parseDateTime(a.time).compareTo(_parseDateTime(b.time)));
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(minutes: 1), (timer) {
      _removeExpiredTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Schedule'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showAddTaskDialog(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            return _buildTaskItem(tasks[index]);
          },
        ),
      ),
    );
  }

  Widget _buildTaskItem(Task task) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(
          task.name,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Text('Time: ${task.time}'),
            SizedBox(height: 4),
            Text('Duration: ${task.duration}'),
          ],
        ),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    final List<String> times = [
      '12:00 AM', '1:00 AM', '2:00 AM', '3:00 AM', '4:00 AM', '5:00 AM', '6:00 AM', '7:00 AM',
      '8:00 AM', '9:00 AM', '10:00 AM', '11:00 AM', '12:00 PM', '1:00 PM', '2:00 PM', '3:00 PM',
      '4:00 PM', '5:00 PM', '6:00 PM', '7:00 PM', '8:00 PM', '9:00 PM', '10:00 PM', '11:00 PM',
    ];

    final List<String> durations = [
      '15 minutes', '30 minutes', '45 minutes', '1 hour', '1 hour 30 minutes', '2 hours',
      '2 hours 30 minutes', '3 hours', '3 hours 30 minutes', '4 hours', '4 hours 30 minutes',
      '5 hours', '5 hours 30 minutes', '6 hours', '6 hours 30 minutes', '7 hours', '7 hours 30 minutes',
      '8 hours', '8 hours 30 minutes', '9 hours', '9 hours 30 minutes', '10 hours', '10 hours 30 minutes',
      '11 hours', '11 hours 30 minutes', '12 hours', '12 hours 30 minutes',
    ];

    String selectedTime = times[0];
    String selectedDuration = durations[0];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Task'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _taskNameController,
                  decoration: InputDecoration(labelText: 'Task Name'),
                ),
                DropdownButtonFormField<String>(
                  value: selectedTime,
                  items: times.map((time) {
                    return DropdownMenuItem<String>(
                      value: time,
                      child: Text(time),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedTime = value!;
                    });
                  },
                  decoration: InputDecoration(labelText: 'Time'),
                ),
                DropdownButtonFormField<String>(
                  value: selectedDuration,
                  items: durations.map((duration) {
                    return DropdownMenuItem<String>(
                      value: duration,
                      child: Text(duration),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedDuration = value!;
                    });
                  },
                  decoration: InputDecoration(labelText: 'Duration'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  tasks.add(Task(
                    name: _taskNameController.text,
                    time: selectedTime,
                    duration: selectedDuration,
                  ));
                  tasks.sort((a, b) => _parseDateTime(a.time).compareTo(_parseDateTime(b.time)));
                });
                Navigator.pop(context); // Close dialog
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _removeExpiredTasks() {
    final now = DateTime.now();
    final List<Task> tasksToRemove = [];

    for (final task in tasks) {
      final taskTime = _parseDateTime(task.time);
      if (taskTime.isBefore(now)) {
        tasksToRemove.add(task);
      }
    }

    setState(() {
      tasksToRemove.forEach((task) {
        tasks.remove(task);
      });
    });
  }

  DateTime _parseDateTime(String time) {
    final parts = time.split(' ');
    final timeParts = parts[0].split(':');
    final hour = int.parse(timeParts[0]);
    final minute = int.parse(timeParts[1]);
    final meridiem = parts[1].toLowerCase();
    DateTime now = DateTime.now();
    DateTime dateTime = DateTime(now.year, now.month, now.day, hour, minute);
    if (meridiem == 'pm' && hour < 12) {
      dateTime = dateTime.add(Duration(hours: 12));
    }
    return dateTime;
  }
}

class Task {
  final String name;
  final String time;
  final String duration;

  Task({required this.name, required this.time, required this.duration});
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: DailySchedulePage(),
  ));
}
