import 'package:flutter/material.dart';

class ModuleNotices extends StatefulWidget {
  @override
  _ModuleNoticesState createState() => _ModuleNoticesState();
}

class _ModuleNoticesState extends State<ModuleNotices>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notice Details'),
      ),
      body: Container(
        color: Colors.grey[200], // set the background color
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: ListView(
            children: [
              ScaleTransition(
                scale: _animation,
                child: const Text(
                  'Notices',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Important message regarding the upcoming MID exams',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Check the hall allocation to locate your examination hall and the seat number before the examination. Check whether your netExam login is working before the date of the examination. Be present near the examination hall at least 15 minutes before the examination. Do not enter the examination hall before the supervisor ask you to enter the hall Make sure that you have your student ID with you. You may bring authorized materials such as pens and pencils to the examination hall. It is recommended that you keep the materials in a transparent pencil case.',
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Posted on: 2022-03-20',
                            style: TextStyle(fontSize: 12),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('Year 4'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'CTSE Assignment 1',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'This is a group project, and in each group, there should be four/less than four members. This Assignment is worth 25% of the Total Grade. This Assessment will be Due on 25th of March 2023 at 5:00 PM.',
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Posted on: 2022-02-20',
                            style: TextStyle(fontSize: 12),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('Year 4'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'FINAL exams notices',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Check the hall allocation to locate your examination hall and the seat number before the examination. Check whether your netExam login is working before the date of the examination. Be present near the examination hall at least 15 minutes before the examination. Do not enter the examination hall before the supervisor ask you to enter the hall Make sure that you have your student ID with you. You may bring authorized materials such as pens and pencils to the examination hall. It is recommended that you keep the materials in a transparent pencil case.',
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Posted on: 2022-03-20',
                            style: TextStyle(fontSize: 12),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('Year 4'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
