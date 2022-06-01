import 'package:exams/screens/Login.dart';
import 'package:exams/screens/Signup.dart';
import 'package:exams/screens/forgot_pasword.dart';
import 'package:exams/screens/home_page.dart';
import 'package:exams/screens/welcome_screen.dart';
import 'package:exams/services/helper_functoins.dart';
import 'package:exams/utils/comon_widgets.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoggedIn = false;
  bool isLoading = false;

  checkUserLoggedIn() async {
    try {
      setState(() {
        isLoading = true;
      });
      await HelperFunctions().getUserLoggedInDetails().then((value) {
        if (value != null) {
          setState(() {
            isLoggedIn = value;
          });
        }
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    checkUserLoggedIn();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: isLoading
            ? Center(
                child: loadingRow(),
              )
            : isLoggedIn
                ? const HomeDashBoard()
                : WelcomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> pages = const [Signup(), Login(), ForgotPassword()];

  changePage() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemCount: pages.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, i) {
          return pages[i];
        },
        //children: const [Signup(), Login(), ForgotPassword()],
      ),
    );
  }
}
