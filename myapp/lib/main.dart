import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Subject Enrollment',

      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF4F8FC),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2196F3),
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2196F3),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          labelStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Color(0xFFD5DDE5),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Color(0xFF2196F3),
              width: 2,
            ),
          ),
        ),
      ),

      home: const RegistrationPage(),
    );
  }
}

// ===============================
// REGISTRATION PAGE
// ===============================

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final nameController = TextEditingController();
  final sectionController = TextEditingController();
  final courseController = TextEditingController();

  void nextPage() {
    if (nameController.text.trim().isEmpty ||
        sectionController.text.trim().isEmpty ||
        courseController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields.'),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SubjectEnrollmentPage(
          name: nameController.text.trim(),
          section: sectionController.text.trim(),
          course: courseController.text.trim(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    sectionController.dispose();
    courseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Registration'),
      ),

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 550),

            child: Card(
              color: Colors.white,
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),

              child: Padding(
                padding: const EdgeInsets.all(25),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,

                  children: [
                    const Icon(
                      Icons.person,
                      size: 55,
                      color: Color(0xFF2196F3),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      'Student Registration',
                      textAlign: TextAlign.center,

                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF222222),
                      ),
                    ),

                    const SizedBox(height: 5),

                    const Text(
                      'Enter your student information',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),

                    const SizedBox(height: 25),

                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                    ),

                    const SizedBox(height: 16),

                    TextField(
                      controller: sectionController,
                      decoration: const InputDecoration(
                        labelText: 'Section',
                        prefixIcon: Icon(Icons.class_outlined),
                      ),
                    ),

                    const SizedBox(height: 16),

                    TextField(
                      controller: courseController,
                      decoration: const InputDecoration(
                        labelText: 'Course',
                        prefixIcon: Icon(Icons.school_outlined),
                      ),
                    ),

                    const SizedBox(height: 25),

                    SizedBox(
                      height: 50,

                      child: ElevatedButton(
                        onPressed: nextPage,

                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2196F3),
                          foregroundColor: Colors.white,

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),

                        child: const Text(
                          'NEXT',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ===============================
// SUBJECT ENROLLMENT PAGE
// ===============================

class SubjectEnrollmentPage extends StatefulWidget {
  final String name;
  final String section;
  final String course;

  const SubjectEnrollmentPage({
    super.key,
    required this.name,
    required this.section,
    required this.course,
  });

  @override
  State<SubjectEnrollmentPage> createState() =>
      _SubjectEnrollmentPageState();
}

class _SubjectEnrollmentPageState extends State<SubjectEnrollmentPage> {
  final subject1Controller = TextEditingController();
  final time1Controller = TextEditingController();

  final subject2Controller = TextEditingController();
  final time2Controller = TextEditingController();

  void nextPage() {
    if (subject1Controller.text.trim().isEmpty ||
        time1Controller.text.trim().isEmpty ||
        subject2Controller.text.trim().isEmpty ||
        time2Controller.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all subject fields.'),
        ),
      );

      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SubjectVerificationPage(
          name: widget.name,
          section: widget.section,
          course: widget.course,
          subject1: subject1Controller.text.trim(),
          time1: time1Controller.text.trim(),
          subject2: subject2Controller.text.trim(),
          time2: time2Controller.text.trim(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    subject1Controller.dispose();
    time1Controller.dispose();
    subject2Controller.dispose();
    time2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subject Enrollment'),
      ),

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 550),

            child: Card(
              color: Colors.white,
              elevation: 3,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),

              child: Padding(
                padding: const EdgeInsets.all(25),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,

                  children: [
                    const Icon(
                      Icons.menu_book,
                      size: 55,
                      color: Color(0xFF2196F3),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      'Subject Enrollment',
                      textAlign: TextAlign.center,

                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF222222),
                      ),
                    ),

                    const SizedBox(height: 25),

                    const Text(
                      'Subject 1',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2196F3),
                      ),
                    ),

                    const SizedBox(height: 12),

                    TextField(
                      controller: subject1Controller,
                      decoration: const InputDecoration(
                        labelText: 'Subject',
                        prefixIcon: Icon(Icons.book_outlined),
                      ),
                    ),

                    const SizedBox(height: 15),

                    TextField(
                      controller: time1Controller,
                      decoration: const InputDecoration(
                        labelText: 'Time',
                        hintText: 'Example: 7:30 - 10:30',
                        prefixIcon: Icon(Icons.access_time),
                      ),
                    ),

                    const SizedBox(height: 25),

                    const Divider(),

                    const SizedBox(height: 15),

                    const Text(
                      'Subject 2',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2196F3),
                      ),
                    ),

                    const SizedBox(height: 12),

                    TextField(
                      controller: subject2Controller,
                      decoration: const InputDecoration(
                        labelText: 'Subject',
                        prefixIcon: Icon(Icons.book_outlined),
                      ),
                    ),

                    const SizedBox(height: 15),

                    TextField(
                      controller: time2Controller,
                      decoration: const InputDecoration(
                        labelText: 'Time',
                        hintText: 'Example: 12:30 - 1:30',
                        prefixIcon: Icon(Icons.access_time),
                      ),
                    ),

                    const SizedBox(height: 25),

                    SizedBox(
                      height: 50,

                      child: ElevatedButton(
                        onPressed: nextPage,

                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2196F3),
                          foregroundColor: Colors.white,

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),

                        child: const Text(
                          'NEXT',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ===============================
// VERIFICATION PAGE
// ===============================

class SubjectVerificationPage extends StatefulWidget {
  final String name;
  final String section;
  final String course;

  final String subject1;
  final String time1;

  final String subject2;
  final String time2;

  const SubjectVerificationPage({
    super.key,
    required this.name,
    required this.section,
    required this.course,
    required this.subject1,
    required this.time1,
    required this.subject2,
    required this.time2,
  });

  @override
  State<SubjectVerificationPage> createState() =>
      _SubjectVerificationPageState();
}

class _SubjectVerificationPageState
    extends State<SubjectVerificationPage> {

  bool isSaving = false;

  // ===============================
  // SAVE TO FIREBASE
  // ===============================

  Future<void> saveToFirebase() async {
    if (isSaving) return;

    setState(() {
      isSaving = true;
    });

    try {
      // SAVE DATA TO FIRESTORE
      DocumentReference document =
          await FirebaseFirestore.instance
              .collection('student_enrollments')
              .add({
        'name': widget.name,
        'section': widget.section,
        'course': widget.course,
        'subject1': widget.subject1,
        'time1': widget.time1,
        'subject2': widget.subject2,
        'time2': widget.time2,
        'createdAt': Timestamp.now(),
      });

      print('================================');
      print('FIREBASE SAVE SUCCESSFUL');
      print('Document ID: ${document.id}');
      print('================================');

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Saved successfully to Firebase!',
          ),
          backgroundColor: Colors.green,
        ),
      );

      await Future.delayed(
        const Duration(seconds: 1),
      );

      if (!mounted) return;

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const RegistrationPage(),
        ),
        (route) => false,
      );

    } catch (e) {
      print('================================');
      print('FIREBASE SAVE ERROR');
      print(e);
      print('================================');

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Firebase Error: $e',
          ),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 5),
        ),
      );
    }

    if (mounted) {
      setState(() {
        isSaving = false;
      });
    }
  }

  Widget infoRow(
    String label,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),

      child: Container(
        padding: const EdgeInsets.all(12),

        decoration: BoxDecoration(
          color: const Color(0xFFF4F8FC),
          borderRadius: BorderRadius.circular(8),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              label,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 13,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              value,
              style: const TextStyle(
                color: Color(0xFF222222),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verification'),
      ),

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 550),

            child: Card(
              color: Colors.white,
              elevation: 3,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),

              child: Padding(
                padding: const EdgeInsets.all(25),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,

                  children: [
                    const Icon(
                      Icons.check_circle_outline,
                      size: 55,
                      color: Color(0xFF2196F3),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      'Verify Information',
                      textAlign: TextAlign.center,

                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF222222),
                      ),
                    ),

                    const SizedBox(height: 5),

                    const Text(
                      'Check your information before saving.',
                      textAlign: TextAlign.center,

                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 25),

                    infoRow('Name', widget.name),
                    infoRow('Section', widget.section),
                    infoRow('Course', widget.course),

                    const Divider(),

                    const SizedBox(height: 15),

                    infoRow('Subject 1', widget.subject1),
                    infoRow('Time', widget.time1),

                    infoRow('Subject 2', widget.subject2),
                    infoRow('Time', widget.time2),

                    const SizedBox(height: 10),

                    SizedBox(
                      height: 50,

                      child: ElevatedButton(
                        onPressed: isSaving
                            ? null
                            : saveToFirebase,

                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2196F3),
                          foregroundColor: Colors.white,

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),

                        child: isSaving
                            ? const SizedBox(
                                width: 22,
                                height: 22,

                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text(
                                'SAVE TO FIREBASE',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
