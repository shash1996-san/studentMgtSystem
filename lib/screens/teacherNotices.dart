import 'package:flutter/material.dart';

//teacher notices
class TeacherNotices extends StatefulWidget {
  @override
  //create state
  _TeacherNoticesState createState() => _TeacherNoticesState();
}

class _TeacherNoticesState extends State<TeacherNotices>
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
              //animation
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
                        'Transfer to Weekend Program: Feb-June 2023 (Only for 3rd Year)',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        ' Those who have submitted a legitimate offer letter/ letter of employment from the employer/company for the applicable period of the semester. (Those who have submitted the above in the previous semester are required to submit the letter again for the current semester).',
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Posted on: 2022-03-23',
                            style: TextStyle(fontSize: 12),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('Year 3'),
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
                        '2023 Feb- June Semester',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Semester 1 (Feb-June), 2023 of the Faculty of Computing will commence on the 6th of February 2023 for Year 1 Semester 1, Year 2, 3 and 4',
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Posted on: 2022-01-28',
                            style: TextStyle(fontSize: 12),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('Year 1'),
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
                            'Posted on: 2022-03-24',
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
