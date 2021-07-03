import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String title = 'Семейные покупки';
    return MaterialApp(
      title: title,
      home: AppStarted(title: title),
    );
  }
}

class AppStarted extends StatelessWidget {
  final String title;
  AppStarted({Key? key, required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          Builder(builder: (BuildContext context) {
            return ElevatedButton(
              child: const Text('Выйти'),
              onPressed: () async {
                final User? user = _auth.currentUser;
                if (user == null) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Вы не авторизованы'),
                  ));
                  return;
                }
                await _auth.signOut();
                final String uid = user.uid;
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(uid + ' успешный выход.'),
                ));
              },
            );
          })
        ],
      ),
      body: Builder(builder: (BuildContext context) {
        return ListView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(16),
          children: <Widget>[_RegisterEmailSection()],
        );
      }),
    );
  }
}

class _RegisterEmailSection extends StatefulWidget {
  final String title = 'Регистрация';
  @override
  State<StatefulWidget> createState() => _RegisterEmailSectionState();
}

class _RegisterEmailSectionState extends State<_RegisterEmailSection> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _success = false;
  String _userEmail = "";
  void _register() async {
    final User? user = (await _auth.createUserWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    ))
        .user;
    setState(() {
      _success = true;
      _userEmail = user!.email!;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Пожалуйста введите почту';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Пароль'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Пожалуйста введите пароль';
                }
                return null;
              },
            ),
            Container(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _register();
                  }
                },
                child: const Text('Отправить'),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Text(_success == null
                  ? ''
                  : (_success
                      ? 'Успешная регистрация ' + _userEmail
                      : 'Регистрация не пройдена, повторите еще раз')),
            )
          ],
        ),
      ),
    );
  }
}
