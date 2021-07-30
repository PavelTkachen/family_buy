import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:family_buy/providers/login_provider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  @override
  void initState() {
    _email = TextEditingController(text: "");
    _password = TextEditingController(text: "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: _email,
            decoration: InputDecoration(labelText: 'Email'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Пожалуйста введите почту';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _password,
            decoration: InputDecoration(labelText: 'Пароль'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Пожалуйста введите пароль';
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                if (!await context
                    .read<LoginProvider>()
                    .signIn(_email.text, _password.text)) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Ошибка авторизации'),
                  ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Успешная авторизация')));
                }
              }
            },
            child: Text('Отправить'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }
}
