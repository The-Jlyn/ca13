import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_3/authentication_screen.dart';
// import 'package:flutter_application_3/home_page.dart';
import 'firebase_options.dart';
// import 'authservice.dart';
import 'profile_screen.dart';
// import 'registrationwidget.dart';
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
      title: 'Firebase Auth Demo',
      home: const AuthenticationScreen(),  // Replace with the actual starting widget
      routes: {
        '/profile': (context) => ProfileScreen(),
        // '/': (context) => AuthenticationScreen(),
        '/home': (context) => ProfileScreen(),
        // Add other routes as needed
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
const MyHomePage({Key? key, required this.title}) : super(key: key);
final String title;
@override
_MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
final FirebaseAuth _auth = FirebaseAuth.instance;
void _signOut() async {
await _auth.signOut();
ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
content: Text('Signed out successfully'),
));
}
@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: Text(widget.title),
actions: <Widget>[
ElevatedButton(
onPressed: () {
_signOut();
},
child: const Text('Sign Out'),
),
],
),
body: Center(
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: <Widget>[
RegisterEmailSection(auth: _auth),
EmailPasswordForm(auth: _auth),
],
),
),
);
}
}
class RegisterEmailSection extends StatefulWidget {
const RegisterEmailSection({Key? key, required this.auth}) : super(key: key);
final FirebaseAuth auth;
@override
_RegisterEmailSectionState createState() => _RegisterEmailSectionState();
}
class _RegisterEmailSectionState extends State<RegisterEmailSection> {
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController =
TextEditingController();
bool _success = false;
bool _initialState = true;
String? _userEmail;
void _register() async {
try {
await widget.auth.createUserWithEmailAndPassword(
email: _emailController.text,
password: _passwordController.text,
);
setState(() {
_success = true;
_userEmail = _emailController.text;
_initialState = false;
});
} catch (e) {
setState(() {
_success = false;
_initialState = false;
});
}
}
@override
Widget build(BuildContext context) {
return Form(
key: _formKey,
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: <Widget>[
TextFormField(
controller: _emailController,
decoration: const InputDecoration(labelText: 'Email'),
validator: (value) {
if (value?.isEmpty??true) {
return 'Please enter some text';
}
return null;
},
),
TextFormField(
controller: _passwordController,
decoration: const InputDecoration(labelText: 'Password'),
validator: (value) {
if(value?.isEmpty??true) {
return 'Please enter some text';
}
return null;
},
),
Container(
padding: const EdgeInsets.symmetric(vertical: 16.0),
alignment: Alignment.center,
child: ElevatedButton(
onPressed: () {
if (_formKey.currentState!.validate()) {
_register();
}
},
child: const Text('Submit'),
),
),
Container(
alignment: Alignment.center,
child: Text(
_initialState
? 'Please Register'
: _success
? 'Successfully registered $_userEmail'
: 'Registration failed',
style: TextStyle(color: _success ? Colors.green :
Colors.red),
),
),
],
),
);
}
}
class EmailPasswordForm extends StatefulWidget {
const EmailPasswordForm({Key? key, required this.auth}) : super(key: key);
final FirebaseAuth auth;
@override
_EmailPasswordFormState createState() => _EmailPasswordFormState();
}
class _EmailPasswordFormState extends State<EmailPasswordForm> {
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController =
TextEditingController();
bool _success = false;
bool _initialState = true;
String _userEmail ='';
void _signInWithEmailAndPassword() async {
try {
await widget.auth.signInWithEmailAndPassword(
email: _emailController.text,
password: _passwordController.text,
);
setState(() {
_success = true;
_userEmail = _emailController.text;
_initialState = false;
});
} catch (e) {
setState(() {
_success = false;
_initialState = false;
});
}
}
@override
Widget build(BuildContext context) {
return Form(
key: _formKey,
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: <Widget>[
Container(
child: const Text('Test sign in with email and password'),
padding: const EdgeInsets.all(16),
alignment: Alignment.center,
),
TextFormField(
controller: _emailController,
decoration: const InputDecoration(labelText: 'Email'),
validator: (value) {
if (value?.isEmpty??true) {
return 'Please enter some text';
}
return null;
},
),
TextFormField(
controller: _passwordController,
decoration: const InputDecoration(labelText: 'Password'),
validator: (value) {
if (value?.isEmpty??true) {
return 'Please enter some text';
}
return null;
},
),
Container(
padding: const EdgeInsets.symmetric(vertical: 16.0),
alignment: Alignment.center,
child: ElevatedButton(
onPressed: () {
if (_formKey.currentState!.validate()) {
_signInWithEmailAndPassword();
}
},
child: const Text('Submit'),
),
),
Container(
alignment: Alignment.center,
padding: const EdgeInsets.symmetric(horizontal: 16),
child: Text(
_initialState
? 'Please sign in'
: _success
? 'Successfully signed in $_userEmail'
: 'Sign in failed',
style: TextStyle(color: _success ? Colors.green :
Colors.red),
),
),
],
),
);
}
}


// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   // Register user with email and password
//   Future<User?> registerWithEmailAndPassword(String email, String password) async {
//     try {
//       UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       return userCredential.user;
//     } catch (e) {
//       print("Registration Error: $e");
//       return null;
//     }
//   }

//   // Sign in user with email and password
//   Future<User?> signInWithEmailAndPassword(String email, String password) async {
//     try {
//       UserCredential userCredential = await _auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       return userCredential.user;
//     } catch (e) {
//       print("Sign-In Error: $e");
//       return null;
//     }
//   }

//   // Sign out the current user
//   Future<void> signOut() async {
//     await _auth.signOut();
//   }

//   // Reset password
//   Future<void> resetPassword(String email) async {
//     await _auth.sendPasswordResetEmail(email: email);
//   }
// }




















// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// import 'package:flutter/material.dart';
// import 'authentication_screen.dart';
// import 'home_page.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       initialRoute: '/',
//       routes: {
//         '/': (context) => const AuthenticationScreen(),
//         '/home': (context) => const HomePage(),
//       },
//     );
//   }
// }


// void main() async {
// WidgetsFlutterBinding.ensureInitialized();
// await Firebase.initializeApp(
// options: DefaultFirebaseOptions.currentPlatform,
// );
// runApp(const MyApp());
// }



// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   // Method for user registration
//   Future<User?> registerWithEmailAndPassword(String email, String password) async {
//     try {
//       UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       return userCredential.user;
//     } catch (e) {
//       print("Registration Error: $e");
//       return null;
//     }
//   }

//   // Method for user sign-in
//   Future<User?> signInWithEmailAndPassword(String email, String password) async {
//     try {
//       UserCredential userCredential = await _auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       return userCredential.user;
//     } catch (e) {
//       print("Sign-In Error: $e");
//       return null;
//     }
//   }

//   // Method for user sign-out
//   Future<void> signOut() async {
//     await _auth.signOut();
//   }
// }


// class RegisterWidget extends StatefulWidget {
//   const RegisterWidget({super.key});

//   @override
//   _RegisterWidgetState createState() => _RegisterWidgetState();
// }

// class _RegisterWidgetState extends State<RegisterWidget> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final AuthService _authService = AuthService();

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         TextField(
//           controller: _emailController,
//           decoration: const InputDecoration(labelText: 'Email'),
//         ),
//         TextField(
//           controller: _passwordController,
//           decoration: const InputDecoration(labelText: 'Password'),
//           obscureText: true,
//         ),
//         ElevatedButton(
//           onPressed: () async {
//             User? user = await _authService.registerWithEmailAndPassword(
//               _emailController.text,
//               _passwordController.text,
//             );
//             if (user != null) {
//               Navigator.pushReplacementNamed(context, '/home');
//             }
//           },
//           child: const Text('Register'),
//         ),
//       ],
//     );
//   }
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // TRY THIS: Try running your application with "flutter run". You'll see
//         // the application has a purple toolbar. Then, without quitting the app,
//         // try changing the seedColor in the colorScheme below to Colors.green
//         // and then invoke "hot reload" (save your changes or press the "hot
//         // reload" button in a Flutter-supported IDE, or press "r" if you used
//         // the command line to start the app).
//         //
//         // Notice that the counter didn't reset back to zero; the application
//         // state is not lost during the reload. To reset the state, use hot
//         // restart instead.
//         //
//         // This works for code too, not just values: Most code changes can be
//         // tested with just a hot reload.
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // TRY THIS: Try changing the color here to a specific color (to
//         // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
//         // change color while the other colors stay the same.
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           //
//           // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
//           // action in the IDE, or press "p" in the console), to see the
//           // wireframe for each widget.
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
