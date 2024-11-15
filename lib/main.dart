import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const ConcreteApp());
}

class ConcreteApp extends StatelessWidget {
  const ConcreteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trenton\'s Concrete Tracker',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        scaffoldBackgroundColor: Colors.black,
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontFamily: 'Comic Sans MS', fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.yellow, // Button background color
            foregroundColor: Colors.black, // Text color for the button
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // Rounded corners
            ),
          ),
        ),
      ),
      home: const ConcreteTracker(),
    );
  }
}

class ConcreteTracker extends StatefulWidget {
  const ConcreteTracker({super.key});

  @override
  _ConcreteTrackerState createState() => _ConcreteTrackerState();
}

class _ConcreteTrackerState extends State<ConcreteTracker> {
  DateTime? startPourTime;
  DateTime? endPourTime;
  DateTime? sampleTime;
  List<String> pourTimes = [];
  int truckCount = 0;
  DateFormat dateFormat = DateFormat('h:mm a');
  
  void startPour() {
    setState(() {
      startPourTime = DateTime.now();
      truckCount++;
      pourTimes.add("Truck #$truckCount Start: ${dateFormat.format(startPourTime!)}");
    });
  }

  void endPour() {
    setState(() {
      endPourTime = DateTime.now();
      pourTimes.add("Truck #$truckCount End: ${dateFormat.format(endPourTime!)}");
    });
  }

  void recordSample() {
    setState(() {
      sampleTime = DateTime.now();
      pourTimes.add("Sample Taken: ${dateFormat.format(sampleTime!)}");
    });
  }

  void resetPour() {
    setState(() {
      startPourTime = null;
      endPourTime = null;
      sampleTime = null;
      pourTimes.clear();
      truckCount = 0;
    });
  }

  String get liveEstimatedTime {
    if (startPourTime != null) {
      final elapsed = DateTime.now().difference(startPourTime!);
      return 'Live Estimated Time: ${elapsed.inMinutes} min';
    }
    return 'Live Estimated Time: No active pour';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Trenton's Concrete Tracker", style: TextStyle(fontFamily: 'Comic Sans MS')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              liveEstimatedTime,
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: startPour,
              child: const Text('Start Pour'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: endPour,
              child: const Text('End Pour'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: recordSample,
              child: const Text('Record Sample Time'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: resetPour,
              child: const Text('Reset Pour'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Pour Time Log:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: pourTimes.map((time) {
                    return ListTile(
                      title: Text(time, style: const TextStyle(fontSize: 16, color: Colors.white)),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
